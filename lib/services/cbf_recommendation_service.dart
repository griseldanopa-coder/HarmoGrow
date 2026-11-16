import 'dart:math';
import '../models/kegiatan_model.dart';

class PreferensiInput {
  final String namaAnak;
  final int usiaAnak;
  final List<String> minatKategori;
  final List<String> aktivitasDisukai;
  final List<String> karakterAktivitas;
  final List<String> tujuanKegiatan;

  const PreferensiInput({
    required this.namaAnak,
    required this.usiaAnak,
    required this.minatKategori,
    required this.aktivitasDisukai,
    required this.karakterAktivitas,
    required this.tujuanKegiatan,
  });

  List<String> get allSelectedTags => [
        ...minatKategori,
        ...aktivitasDisukai,
        ...karakterAktivitas,
        ...tujuanKegiatan,
      ];
}

class RekomendasiResult {
  final KegiatanModel kegiatan;
  final double rawCosineSimilarity;
  final int skorPersen;
  final List<String> matchedTags;

  const RekomendasiResult({
    required this.kegiatan,
    required this.rawCosineSimilarity,
    required this.skorPersen,
    required this.matchedTags,
  });
}

/// Implementasi nyata Content-Based Filtering (TF-IDF + Cosine Similarity)
/// untuk mencocokkan profil preferensi anak dengan atribut kegiatan anak usia dini.
class CbfRecommendationService {
  /// Tokenisasi teks menjadi kata-kata dasar (lowercase, bersih dari tanda baca)
  static List<String> _tokenize(List<String> phrases) {
    const stopWords = {'dan', 'yang', 'untuk', 'di', 'ke', 'dari', 'dengan'};
    final tokens = <String>[];
    for (final phrase in phrases) {
      final cleaned = phrase
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9\s]'), ' ')
          .split(RegExp(r'\s+'))
          .where((w) => w.isNotEmpty && !stopWords.contains(w));
      tokens.addAll(cleaned);
    }
    return tokens;
  }

  /// Menghitung rekomendasi terurut berdasarkan TF-IDF dan Cosine Similarity
  static List<RekomendasiResult> hitungRekomendasi({
    required PreferensiInput preferensi,
    List<KegiatanModel> catalog = dummyKegiatanList,
  }) {
    // Filter kegiatan yang sesuai rentang usia anak (1-5 tahun)
    final eligibleCatalog = catalog
        .where((k) =>
            preferensi.usiaAnak >= k.usiaMin &&
            preferensi.usiaAnak <= k.usiaMax)
        .toList();

    final workingCatalog =
        eligibleCatalog.isNotEmpty ? eligibleCatalog : catalog;

    // 1. Bangun dokumen token untuk Query (Preferensi Anak) dan setiap Item Kegiatan
    final queryTokens = _tokenize(preferensi.allSelectedTags);
    final docTokensList =
        workingCatalog.map((k) => _tokenize(k.tagsCbf)).toList();

    // Jika user belum memilih satupun tag, berikan skor default proporsional rating
    if (queryTokens.isEmpty) {
      return workingCatalog.map((k) {
        final fallbackScore = (k.rating / 5.0 * 75).round();
        return RekomendasiResult(
          kegiatan: k,
          rawCosineSimilarity: fallbackScore / 100.0,
          skorPersen: fallbackScore,
          matchedTags: k.tagsCbf.take(2).toList(),
        );
      }).toList()
        ..sort((a, b) => b.skorPersen.compareTo(a.skorPersen));
    }

    // 2. Bangun Vocabulary unik dari seluruh dokumen + query
    final vocabSet = <String>{...queryTokens};
    for (final docTokens in docTokensList) {
      vocabSet.addAll(docTokens);
    }
    final vocab = vocabSet.toList();

    // 3. Hitung IDF (Inverse Document Frequency) untuk setiap term di vocabulary
    // N = jumlah dokumen kegiatan + 1 dokumen query
    final totalDocs = docTokensList.length + 1;
    final idfMap = <String, double>{};

    for (final term in vocab) {
      int df = 0;
      if (queryTokens.contains(term)) df++;
      for (final doc in docTokensList) {
        if (doc.contains(term)) df++;
      }
      // Smooth IDF: log((N + 1) / (df + 1)) + 1
      idfMap[term] = log((totalDocs + 1) / (df + 1)) + 1.0;
    }

    // Fungsi pembentuk vektor bobot TF-IDF
    List<double> buildTfIdfVector(List<String> tokens) {
      final len = tokens.isEmpty ? 1 : tokens.length;
      final freq = <String, int>{};
      for (final t in tokens) {
        freq[t] = (freq[t] ?? 0) + 1;
      }
      return vocab.map((term) {
        final tf = (freq[term] ?? 0) / len;
        return tf * (idfMap[term] ?? 1.0);
      }).toList();
    }

    // Fungsi Cosine Similarity antara dua vektor
    double cosineSimilarity(List<double> vecA, List<double> vecB) {
      double dotProduct = 0.0;
      double normA = 0.0;
      double normB = 0.0;

      for (int i = 0; i < vecA.length; i++) {
        dotProduct += vecA[i] * vecB[i];
        normA += vecA[i] * vecA[i];
        normB += vecB[i] * vecB[i];
      }

      if (normA == 0.0 || normB == 0.0) return 0.0;
      return dotProduct / (sqrt(normA) * sqrt(normB));
    }

    final queryVector = buildTfIdfVector(queryTokens);

    // 4. Hitung Cosine Similarity untuk setiap item & temukan tag yang cocok
    final results = <RekomendasiResult>[];
    final userSelectedLower =
        preferensi.allSelectedTags.map((e) => e.toLowerCase()).toSet();

    for (int i = 0; i < workingCatalog.length; i++) {
      final kegiatan = workingCatalog[i];
      final itemVector = buildTfIdfVector(docTokensList[i]);
      final sim = cosineSimilarity(queryVector, itemVector);

      // Cari tag yang beririsan langsung atau berbagi kata kunci dengan pilihan user
      final matched = <String>[];
      for (final tag in kegiatan.tagsCbf) {
        if (userSelectedLower.contains(tag.toLowerCase())) {
          matched.add(tag);
        } else {
          final tagWords = _tokenize([tag]);
          if (tagWords.any((w) => queryTokens.contains(w))) {
            matched.add(tag);
          }
        }
      }

      // Skala presentasi UI agar informatif (rentang 55% - 98% jika ada kecocokan)
      int displayPercent;
      if (sim <= 0.0) {
        displayPercent = 45;
      } else {
        displayPercent = (58 + (sim * 42)).round().clamp(50, 98);
      }

      results.add(
        RekomendasiResult(
          kegiatan: kegiatan,
          rawCosineSimilarity: sim,
          skorPersen: displayPercent,
          matchedTags: matched.isNotEmpty
              ? matched.take(3).toList()
              : kegiatan.tagsCbf.take(2).toList(),
        ),
      );
    }

    // 5. Urutkan dari skor kemiripan tertinggi ke terendah
    results.sort((a, b) {
      final cmp = b.rawCosineSimilarity.compareTo(a.rawCosineSimilarity);
      if (cmp != 0) return cmp;
      return b.kegiatan.rating.compareTo(a.kegiatan.rating);
    });

    return results;
  }
}
