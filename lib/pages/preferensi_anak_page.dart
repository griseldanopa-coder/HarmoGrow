import 'package:flutter/material.dart';
import '../services/cbf_recommendation_service.dart';
import 'hasil_rekomendasi_page.dart';

class PreferensiAnakPage extends StatefulWidget {
  final PreferensiInput? initialPreferensi;

  const PreferensiAnakPage({super.key, this.initialPreferensi});

  @override
  State<PreferensiAnakPage> createState() => _PreferensiAnakPageState();
}

class _PreferensiAnakPageState extends State<PreferensiAnakPage> {
  int _selectedUsia = 4;

  late Set<String> _selectedMinat;
  late Set<String> _selectedAktivitas;
  late Set<String> _selectedKarakter;
  late Set<String> _selectedTujuan;

  final List<String> _minatOptions = [
    'Olahraga dan Gerak',
    'Seni dan Kreativitas',
    'Musik dan Tari',
    'Kognitif dan Bahasa',
    'Keterampilan Sehari-hari dan Sensorik',
  ];

  final List<String> _aktivitasOptions = [
    'Berenang',
    'Bermain bola',
    'Bela diri',
    'Menggambar dan mewarnai',
    'Melukis',
    'Bernyanyi',
    'Bermain alat musik',
    'Menari',
    'Membaca cerita',
    'Belajar mengenal huruf dan angka',
    'Bermain puzzle',
    'Eksplorasi tekstur dan sensorik',
    'Memasak sederhana',
  ];

  final List<String> _karakterOptions = [
    'Aktif dan banyak bergerak',
    'Tenang dan fokus',
    'Kreatif dan bereksplorasi',
    'Suka berinteraksi dan bekerja sama',
    'Suka mencoba hal baru',
  ];

  final List<String> _tujuanOptions = [
    'Mengembangkan kemampuan motorik',
    'Mengembangkan kreativitas',
    'Melatih kemampuan berpikir dan bahasa',
    'Meningkatkan kemampuan sosial',
    'Melatih kemandirian',
  ];

  @override
  void initState() {
    super.initState();
    final init = widget.initialPreferensi;
    if (init != null) {
      _selectedUsia = init.usiaAnak;
      _selectedMinat = init.minatKategori.toSet();
      _selectedAktivitas = init.aktivitasDisukai.toSet();
      _selectedKarakter = init.karakterAktivitas.toSet();
      _selectedTujuan = init.tujuanKegiatan.toSet();
    } else {
      // Default pilihan awal sesuai mockup Figma agar user bisa langsung klik Lanjutkan atau ubah
      _selectedUsia = 4;
      _selectedMinat = {'Olahraga dan Gerak', 'Seni dan Kreativitas'};
      _selectedAktivitas = {'Berenang', 'Menggambar dan mewarnai'};
      _selectedKarakter = {'Aktif dan banyak bergerak'};
      _selectedTujuan = {'Mengembangkan kemampuan motorik'};
    }
  }

  void _toggleOption(Set<String> targetSet, String value) {
    setState(() {
      if (targetSet.contains(value)) {
        targetSet.remove(value);
      } else {
        targetSet.add(value);
      }
    });
  }

  void _prosesRekomendasiCbf() {
    final preferensi = PreferensiInput(
      namaAnak: 'Anak pertama',
      usiaAnak: _selectedUsia,
      minatKategori: _selectedMinat.toList(),
      aktivitasDisukai: _selectedAktivitas.toList(),
      karakterAktivitas: _selectedKarakter.toList(),
      tujuanKegiatan: _selectedTujuan.toList(),
    );

    final hasilCbf = CbfRecommendationService.hitungRekomendasi(
      preferensi: preferensi,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HasilRekomendasiPage(
          preferensi: preferensi,
          hasilRekomendasi: hasilCbf,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E5BB8),
      body: Column(
        children: [
          // AppBar Biru
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.chevron_left_rounded,
                        color: Color(0xFF1E5BB8),
                        size: 26,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Rekomendasi Kegiatan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 38),
                ],
              ),
            ),
          ),

          // Body Putih Abu Melengkung
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F7FC),
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                child: Column(
                  children: [
                    // Kartu Kenali Minat Anak
                    _buildSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Kenali Minat Anak',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Lengkapi informasi berikut agar kami dapat merekomendasikan kegiatan yang sesuai dengan usia dan minat anak.',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Color(0xFF475569),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text(
                                'Preferensi Anak',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E5BB8),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  '1 dari 2',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: const LinearProgressIndicator(
                              value: 0.5,
                              minHeight: 5,
                              backgroundColor: Color(0xFFDBEAFE),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF1E5BB8)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 1. Pilih Anak
                    _buildSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '1. Pilih Anak',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Profil anak yang ingin dicari rekomendasi kegiatannya.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: const Color(0xFF2563EB), width: 1.3),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFDBEAFE),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.person_outline,
                                      color: Color(0xFF2563EB)),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Anak pertama',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13.5,
                                          color: Color(0xFF1E293B),
                                        ),
                                      ),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton<int>(
                                          value: _selectedUsia,
                                          isDense: true,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF64748B),
                                          ),
                                          items: [1, 2, 3, 4, 5]
                                              .map((u) => DropdownMenuItem(
                                                    value: u,
                                                    child:
                                                        Text('Usia $u tahun'),
                                                  ))
                                              .toList(),
                                          onChanged: (val) {
                                            if (val != null) {
                                              setState(
                                                  () => _selectedUsia = val);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFECFDF5),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: const Color(0xFF10B981)),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check_circle_outline,
                                          size: 14, color: Color(0xFF059669)),
                                      SizedBox(width: 4),
                                      Text(
                                        'Terpilih',
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF059669),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // 2. Apa minat anak Anda?
                    _buildChipQuestionCard(
                      title: '2. Apa minat anak Anda?',
                      subtitle: 'Pilih satu atau lebih kategori yang disukai anak.',
                      options: _minatOptions,
                      selectedSet: _selectedMinat,
                    ),
                    const SizedBox(height: 14),

                    // 3. Aktivitas apa yang disukai anak?
                    _buildChipQuestionCard(
                      title: '3. Aktivitas apa yang disukai anak?',
                      options: _aktivitasOptions,
                      selectedSet: _selectedAktivitas,
                    ),
                    const SizedBox(height: 14),

                    // 4. Bagaimana karakter aktivitas yang disukai anak?
                    _buildChipQuestionCard(
                      title: '4. Bagaimana karakter aktivitas yang disukai anak?',
                      options: _karakterOptions,
                      selectedSet: _selectedKarakter,
                    ),
                    const SizedBox(height: 14),

                    // 5. Apa tujuan yang ingin didukung melalui kegiatan?
                    _buildChipQuestionCard(
                      title:
                          '5. Apa tujuan yang ingin didukung melalui kegiatan?',
                      options: _tujuanOptions,
                      selectedSet: _selectedTujuan,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Bar Biru + Tombol Putih Lanjutkan ->
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 14, 24, 20),
            decoration: const BoxDecoration(
              color: Color(0xFF1E5BB8),
              borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
            ),
            child: Center(
              child: SizedBox(
                width: 210,
                height: 46,
                child: ElevatedButton(
                  onPressed: _prosesRekomendasiCbf,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1E5BB8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 2,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Lanjutkan',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildChipQuestionCard({
    required String title,
    String? subtitle,
    required List<String> options,
    required Set<String> selectedSet,
  }) {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF64748B),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((opt) {
              final isSelected = selectedSet.contains(opt);
              return GestureDetector(
                onTap: () => _toggleOption(selectedSet, opt),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF1E5BB8)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF1E5BB8)
                          : const Color(0xFFCBD5E1),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) ...[
                        const Icon(Icons.check_rounded,
                            color: Colors.white, size: 15),
                        const SizedBox(width: 5),
                      ],
                      Flexible(
                        child: Text(
                          opt,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF1E5BB8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
