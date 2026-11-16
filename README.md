# HarmonyKids — Modul HarmoGrow (Flutter Prototype + Real CBF Engine)

Prototipe interaktif 5 halaman antarmuka mobile **HarmoGrow** lengkap dengan perhitungan algoritma **Content-Based Filtering (TF-IDF + Cosine Similarity)** yang berjalan langsung secara lokal tanpa membutuhkan database atau server backend.

## Cara Menjalankan di VS Code
1. Ekstrak folder `harmogrow_flutter_prototype` ini dan buka di **VS Code**.
2. Buka terminal di VS Code (`Ctrl + ~`), lalu jalankan:
   ```bash
   flutter create . --platforms=web
   flutter pub get
   flutter run -d chrome
   ```
   *(Catatan: `flutter create . --platforms=web` hanya digunakan untuk membuat folder `web/` standar Flutter apabila belum ada, tanpa menimpa folder `lib/` dan `pubspec.yaml`.)*

## Alur 5 Halaman & Fitur
1. **Beranda HarmoGrow (`harmogrow_home_page.dart`)**: Header biru awan, filter lokasi & kategori kegiatan, tombol masuk ke Rekomendasi CBF, serta daftar kartu kegiatan.
2. **Rekomendasi Kegiatan - Preferensi Anak (`preferensi_anak_page.dart`)**: Pemilihan profil anak (usia 1–5 tahun) serta *multi-select chips* untuk Minat, Aktivitas, Karakter, dan Tujuan Kegiatan.
3. **Hasil Rekomendasi CBF (`hasil_rekomendasi_page.dart`)**: Menghitung *TF-IDF* dan *Cosine Similarity* secara *real-time* dari preferensi anak, menampilkan peringkat, skor `Kecocokan XX%`, dan tag yang cocok.
4. **Detail Kegiatan (`detail_kegiatan_page.dart`)**: Detail lengkap instansi, tab `Info / Fasilitas / Ulasan`, ikon fasilitas, jadwal sesi, dan tombol `Daftar Sekarang`.
5. **Pendaftaran Kegiatan (`pendaftaran_kegiatan_page.dart`)**: Form data pendaftar, penghitung jumlah sesi & total biaya otomatis, salin nomor rekening BCA, simulasi unggah bukti bayar, dan konfirmasi pendaftaran.
