import 'package:flutter/material.dart';
import '../models/kegiatan_model.dart';
import 'detail_kegiatan_page.dart';
import 'preferensi_anak_page.dart';

class HarmoGrowHomePage extends StatefulWidget {
  const HarmoGrowHomePage({super.key});

  @override
  State<HarmoGrowHomePage> createState() => _HarmoGrowHomePageState();
}

class _HarmoGrowHomePageState extends State<HarmoGrowHomePage> {
  String _selectedLokasi = 'Semua Lokasi';
  String _selectedKategori = 'Semua Kegiatan';
  int _bottomNavIndex = 0;

  final List<String> _lokasiOptions = [
    'Semua Lokasi',
    'Antapani',
    'Buahbatu',
    'Cibeunying',
    'Dago',
    'Riau',
  ];

  final List<String> _kategoriOptions = [
    'Semua Kegiatan',
    'Kursus Renang',
    'Playground',
    'Seni & Kreativitas',
    'Musik & Tari',
    'Kognitif & Bahasa',
  ];

  List<KegiatanModel> get _filteredKegiatan {
    return dummyKegiatanList.where((item) {
      final matchLokasi = _selectedLokasi == 'Semua Lokasi' ||
          item.kecamatan.toLowerCase() == _selectedLokasi.toLowerCase();
      final matchKategori = _selectedKategori == 'Semua Kegiatan' ||
          item.kategoriUtama.toLowerCase() == _selectedKategori.toLowerCase();
      return matchLokasi && matchKategori;
    }).toList();
  }

  Color _parseHexColor(String hex) {
    final cleaned = hex.replaceAll('#', '');
    return Color(int.parse('FF$cleaned', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredKegiatan;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      body: Column(
        children: [
          // Header Biru Melengkung + Aksen Awan
          _buildCloudHeader(context),

          // Konten Utama
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dropdown Pilih Lokasi
                  _buildLocationDropdown(),
                  const SizedBox(height: 12),

                  // Banner Ajakan Rekomendasi CBF
                  _buildCbfRecommendationBanner(context),
                  const SizedBox(height: 14),

                  // Filter Chips Horizontal
                  SizedBox(
                    height: 38,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _kategoriOptions.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final kat = _kategoriOptions[index];
                        final isSelected = _selectedKategori == kat;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedKategori = kat),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF17468F)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              kat,
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF1E5BB8),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Daftar Kartu Kegiatan
                  if (items.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.search_off_rounded,
                              size: 40, color: Color(0xFF94A3B8)),
                          SizedBox(height: 8),
                          Text(
                            'Tidak ada kegiatan di filter ini',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...items.map((kegiatan) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _buildKegiatanCard(context, kegiatan),
                        )),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildCloudHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 44, 20, 34),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1D5BB8), Color(0xFF2B6FD8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 310,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.chevron_left_rounded,
                          color: Color(0xFF1E3A8A), size: 26),
                      const Text(
                        'HarmoGrow',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2B6FD8),
                          letterSpacing: 0.3,
                        ),
                      ),
                      const Icon(Icons.star_rounded,
                          color: Color(0xFFFACC15), size: 24),
                    ],
                  ),
                ),
                // Ikon Lebah Dekoratif
                Positioned(
                  left: -10,
                  top: -12,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF08A),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Text('🐝', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Aksen gelombang awan putih di bawah header
        Positioned(
          bottom: -1,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 20,
            child: CustomPaint(
              painter: _CloudWavePainter(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedLokasi,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF2563EB)),
          items: _lokasiOptions.map((loc) {
            return DropdownMenuItem(
              value: loc,
              child: Row(
                children: [
                  const Icon(Icons.location_on,
                      color: Color(0xFF2563EB), size: 20),
                  const SizedBox(width: 10),
                  Text(
                    loc == 'Semua Lokasi' ? 'Pilih Lokasi (Kota Bandung)' : loc,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontStyle: loc == 'Semua Lokasi'
                          ? FontStyle.italic
                          : FontStyle.normal,
                      color: loc == 'Semua Lokasi'
                          ? const Color(0xFF64748B)
                          : const Color(0xFF1E293B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() => _selectedLokasi = val);
            }
          },
        ),
      ),
    );
  }

  Widget _buildCbfRecommendationBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E5BB8), Color(0xFF3B82F6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E5BB8).withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.auto_awesome_rounded,
                color: Color(0xFFFDE047), size: 26),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cari Kegiatan Sesuai Minat Anak',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Hitung kecocokan otomatis dengan Content-Based Filtering',
                  style: TextStyle(
                    color: Color(0xFFDBEAFE),
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PreferensiAnakPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1E5BB8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Mulai',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKegiatanCard(BuildContext context, KegiatanModel kegiatan) {
    final fallbackBg = _parseHexColor(kegiatan.themeColorHex);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailKegiatanPage(kegiatan: kegiatan),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                width: 96,
                height: 104,
                child: Image.network(
                  kegiatan.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: fallbackBg.withOpacity(0.18),
                    child: Icon(Icons.child_care_rounded,
                        color: fallbackBg, size: 38),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Info Kanan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          kegiatan.namaInstansi,
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E5BB8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF9C3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded,
                                color: Color(0xFFEAB308), size: 14),
                            const SizedBox(width: 2),
                            Text(
                              kegiatan.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF334155),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${kegiatan.hargaFormatted} ${kegiatan.satuanHarga}',
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1D4ED8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Badge Hijau Terpopuler/Terlaris/Terjangkau
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16803C),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.verified_rounded,
                            color: Colors.white, size: 13),
                        const SizedBox(width: 5),
                        Text(
                          kegiatan.badgeLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on,
                          color: Color(0xFF2563EB), size: 15),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          kegiatan.alamat,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: Color(0xFF475569),
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 66,
      decoration: const BoxDecoration(
        color: Color(0xFF1E5BB8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_outlined, 0),
          _navItem(Icons.favorite_border_rounded, 1),
          _navItem(Icons.notifications_none_rounded, 2),
          _navItem(Icons.settings_outlined, 3),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    final active = _bottomNavIndex == index;
    return IconButton(
      onPressed: () {
        setState(() => _bottomNavIndex = index);
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PreferensiAnakPage()),
          );
        }
      },
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: active ? Colors.white.withOpacity(0.18) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 25),
      ),
    );
  }
}

class _CloudWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF4F7FC)
      ..style = PaintingStyle.fill;

    final path = Path()..moveTo(0, size.height);
    const waveCount = 7;
    final waveWidth = size.width / waveCount;

    for (int i = 0; i < waveCount; i++) {
      final startX = i * waveWidth;
      path.quadraticBezierTo(
        startX + waveWidth * 0.5,
        -6,
        startX + waveWidth,
        size.height * 0.65,
      );
    }

    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
