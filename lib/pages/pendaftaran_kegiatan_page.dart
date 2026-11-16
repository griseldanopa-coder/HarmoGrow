import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/kegiatan_model.dart';
import 'harmogrow_home_page.dart';

class PendaftaranKegiatanPage extends StatefulWidget {
  final KegiatanModel kegiatan;

  const PendaftaranKegiatanPage({super.key, required this.kegiatan});

  @override
  State<PendaftaranKegiatanPage> createState() =>
      _PendaftaranKegiatanPageState();
}

class _PendaftaranKegiatanPageState extends State<PendaftaranKegiatanPage> {
  String _selectedAnak = 'Anak pertama • Usia 4 tahun';
  final _namaOrtuController = TextEditingController();
  final _waController = TextEditingController();
  int _jumlahSesi = 1;
  bool _buktiTerunggah = false;

  final List<String> _anakOptions = [
    'Anak pertama • Usia 4 tahun',
    'Anak kedua • Usia 2 tahun',
  ];

  String _formatRupiah(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(str[i]);
    }
    return 'Rp ${buffer.toString()}';
  }

  @override
  void dispose() {
    _namaOrtuController.dispose();
    _waController.dispose();
    super.dispose();
  }

  void _kirimPendaftaran() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle_rounded,
                color: Color(0xFF10B981), size: 28),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Pendaftaran Terkirim!',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        content: Text(
          'Pendaftaran $_selectedAnak pada ${widget.kegiatan.namaInstansi} ($_jumlahSesi sesi) berhasil dikirim dan menunggu konfirmasi pengelola instansi.',
          style: const TextStyle(fontSize: 13.5, height: 1.4),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HarmoGrowHomePage()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E5BB8),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text('Kembali ke Beranda'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final k = widget.kegiatan;
    final totalBayar = k.harga * _jumlahSesi;

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
                        'Pendaftaran Kegiatan',
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
                    // Kartu Ringkasan Instansi
                    _buildCard(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              width: 64,
                              height: 64,
                              child: Image.network(
                                k.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: const Color(0xFFDBEAFE),
                                  child: const Icon(Icons.pool_rounded,
                                      color: Color(0xFF1E5BB8)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  k.namaInstansi,
                                  style: const TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1E5BB8),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  k.subJudul,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today_rounded,
                                        size: 13, color: Color(0xFF2563EB)),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        k.jadwal,
                                        style: const TextStyle(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF334155),
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
                    const SizedBox(height: 14),

                    // Kartu Data Pendaftar
                    _buildCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data Pendaftar',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Anak yang didaftarkan',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF334155),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: const Color(0xFF2563EB), width: 1.3),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedAnak,
                                isExpanded: true,
                                items: _anakOptions
                                    .map((a) => DropdownMenuItem(
                                          value: a,
                                          child: Row(
                                            children: [
                                              const Icon(Icons.person_outline,
                                                  size: 18,
                                                  color: Color(0xFF2563EB)),
                                              const SizedBox(width: 8),
                                              Text(a,
                                                  style: const TextStyle(
                                                      fontSize: 13)),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (v) {
                                  if (v != null) {
                                    setState(() => _selectedAnak = v);
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Nama Orang Tua/Wali',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF334155),
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _namaOrtuController,
                            decoration: InputDecoration(
                              hintText: 'Masukkan nama lengkap',
                              hintStyle: const TextStyle(
                                  fontSize: 13, color: Color(0xFF94A3B8)),
                              prefixIcon: const Icon(Icons.person_outline,
                                  color: Color(0xFF94A3B8)),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xFFCBD5E1)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xFFCBD5E1)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Nomor WhatsApp',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF334155),
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            controller: _waController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: '08xx xxxx xxxx',
                              hintStyle: const TextStyle(
                                  fontSize: 13, color: Color(0xFF94A3B8)),
                              prefixIcon: const Icon(Icons.phone_outlined,
                                  color: Color(0xFF94A3B8)),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xFFCBD5E1)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xFFCBD5E1)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Kartu Pembayaran
                    _buildCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pembayaran',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Transfer sesuai total pembayaran, lalu unggah bukti pembayaran di bawah ini.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Biaya per sesi',
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      color: Color(0xFF475569))),
                              Text(k.hargaFormatted,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Jumlah sesi',
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      color: Color(0xFF475569))),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: _jumlahSesi > 1
                                        ? () => setState(() => _jumlahSesi--)
                                        : null,
                                    icon: const Icon(
                                        Icons.remove_circle_outline,
                                        size: 20),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text('$_jumlahSesi sesi',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        setState(() => _jumlahSesi++),
                                    icon: const Icon(Icons.add_circle_outline,
                                        size: 20, color: Color(0xFF1E5BB8)),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(height: 22),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Pembayaran',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                _formatRupiah(totalBayar),
                                style: const TextStyle(
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1E5BB8),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Kotak Info Rekening Transfer
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                      Icons.account_balance_rounded,
                                      color: Color(0xFF1E5BB8),
                                      size: 20),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Transfer ke',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF64748B))),
                                      const Text(
                                        'Bank BCA • 1234 567 890',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF0F172A),
                                        ),
                                      ),
                                      Text('a.n. ${k.namaInstansi}',
                                          style: const TextStyle(
                                              fontSize: 11.5,
                                              color: Color(0xFF475569))),
                                    ],
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Clipboard.setData(const ClipboardData(
                                        text: '1234567890'));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Nomor rekening BCA berhasil disalin'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.copy_rounded,
                                      size: 14),
                                  label: const Text('Salin',
                                      style: TextStyle(fontSize: 12)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF1E5BB8),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Unggah Bukti Pembayaran
                          const Text(
                            'Bukti Pembayaran',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF334155),
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              setState(() => _buktiTerunggah = true);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 22, horizontal: 16),
                              decoration: BoxDecoration(
                                color: _buktiTerunggah
                                    ? const Color(0xFFECFDF5)
                                    : const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: _buktiTerunggah
                                      ? const Color(0xFF10B981)
                                      : const Color(0xFF60A5FA),
                                  width: 1.4,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    _buktiTerunggah
                                        ? Icons.check_circle_rounded
                                        : Icons.upload_rounded,
                                    color: _buktiTerunggah
                                        ? const Color(0xFF059669)
                                        : const Color(0xFF2563EB),
                                    size: 28,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _buktiTerunggah
                                        ? 'bukti_transfer_bca.jpg (Terunggah)'
                                        : 'Unggah Bukti Pembayaran',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: _buktiTerunggah
                                          ? const Color(0xFF059669)
                                          : const Color(0xFF1E5BB8),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  const Text(
                                    'Format JPG, PNG, atau PDF • maks. 5 MB',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Info Box Konfirmasi Pengelola
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0EBFF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline_rounded,
                              color: Color(0xFF1E5BB8), size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Pendaftaran dikonfirmasi pengelola instansi setelah bukti pembayaran diverifikasi. Bukti pendaftaran akan dikirim ke aplikasi Anda.',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: Color(0xFF1E3A8A),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Bottom Bar Total + Tombol Kirim Pendaftaran
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
        decoration: const BoxDecoration(
          color: Color(0xFF1E5BB8),
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
                Text(
                  _formatRupiah(totalBayar),
                  style: const TextStyle(
                    fontSize: 18.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: _kirimPendaftaran,
              icon: const Text(
                'Kirim Pendaftaran',
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
              ),
              label: const Icon(Icons.send_rounded, size: 16),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1E5BB8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
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
}
