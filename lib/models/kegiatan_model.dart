class UlasanModel {
  final String namaOrangTua;
  final double rating;
  final String komentar;

  const UlasanModel({
    required this.namaOrangTua,
    required this.rating,
    required this.komentar,
  });
}

class FasilitasItem {
  final String nama;
  final String iconKey;

  const FasilitasItem({
    required this.nama,
    required this.iconKey,
  });
}

class KegiatanModel {
  final String id;
  final String namaInstansi;
  final String kategoriUtama;
  final String subJudul;
  final int harga;
  final String satuanHarga;
  final double rating;
  final int jumlahUlasan;
  final String badgeLabel;
  final String alamat;
  final String kecamatan;
  final String jadwal;
  final String durasiSesi;
  final String deskripsi;
  final String rentangUsia;
  final int usiaMin;
  final int usiaMax;
  final String imageUrl;
  final String themeColorHex;
  final List<FasilitasItem> fasilitas;
  final List<UlasanModel> ulasan;
  final List<String> tagsCbf;

  const KegiatanModel({
    required this.id,
    required this.namaInstansi,
    required this.kategoriUtama,
    required this.subJudul,
    required this.harga,
    required this.satuanHarga,
    required this.rating,
    required this.jumlahUlasan,
    required this.badgeLabel,
    required this.alamat,
    required this.kecamatan,
    required this.jadwal,
    required this.durasiSesi,
    required this.deskripsi,
    required this.rentangUsia,
    required this.usiaMin,
    required this.usiaMax,
    required this.imageUrl,
    required this.themeColorHex,
    required this.fasilitas,
    required this.ulasan,
    required this.tagsCbf,
  });

  String get hargaFormatted {
    final str = harga.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(str[i]);
    }
    return 'Rp ${buffer.toString()}';
  }
}

const List<KegiatanModel> dummyKegiatanList = [
  KegiatanModel(
    id: 'keg-001',
    namaInstansi: 'TinySplash Bandung',
    kategoriUtama: 'Kursus Renang',
    subJudul: 'Kursus Renang Anak Usia Dini',
    harga: 150000,
    satuanHarga: '/Sesi',
    rating: 5.0,
    jumlahUlasan: 120,
    badgeLabel: 'Terpopuler',
    alamat: 'Jl. Antapani No.25, Kota Bandung, Jawa Barat',
    kecamatan: 'Antapani',
    jadwal: 'Sabtu & Minggu • 08:00 - 10:00 WIB',
    durasiSesi: '1 Sesi = 60 Menit',
    deskripsi:
        'Kelas berenang yang menyenangkan dan aman untuk anak usia dini (1–5 tahun). Dipandu oleh instruktur berpengalaman, bersertifikasi, dan ramah anak. Menggunakan kolam air hangat indoor yang aman dan bebas kaporit keras.',
    rentangUsia: '1-5 tahun',
    usiaMin: 1,
    usiaMax: 5,
    imageUrl:
        'https://images.unsplash.com/photo-1519315901367-f34ff9154487?auto=format&fit=crop&w=800&q=80',
    themeColorHex: '#1E88E5',
    fasilitas: [
      FasilitasItem(nama: 'Kolam Air Hangat', iconKey: 'pool'),
      FasilitasItem(nama: 'Instruktur Ramah', iconKey: 'person'),
      FasilitasItem(nama: 'Area Tunggu', iconKey: 'weekend'),
      FasilitasItem(nama: 'Ruang Ganti Anak', iconKey: 'door'),
      FasilitasItem(nama: 'Mainan Air', iconKey: 'toys'),
    ],
    ulasan: [
      UlasanModel(
        namaOrangTua: 'Ibu Rina',
        rating: 5.0,
        komentar:
            'Sangat puas! Instrukturnya sabar banget, anak saya yang tadinya takut air sekarang jadi senang berenang.',
      ),
      UlasanModel(
        namaOrangTua: 'Bapak Dimas',
        rating: 5.0,
        komentar:
            'Kolam air hangatnya bersih dan nyaman untuk balita. Sangat direkomendasikan di daerah Antapani.',
      ),
    ],
    tagsCbf: [
      'Olahraga dan Gerak',
      'Berenang',
      'Aktif dan banyak bergerak',
      'Mengembangkan kemampuan motorik',
      'Suka mencoba hal baru',
      'Motorik',
    ],
  ),
  KegiatanModel(
    id: 'keg-002',
    namaInstansi: 'Creative Play Kid',
    kategoriUtama: 'Seni & Kreativitas',
    subJudul: 'Sanggar Seni & Melukis Anak',
    harga: 100000,
    satuanHarga: '/Sesi',
    rating: 4.8,
    jumlahUlasan: 94,
    badgeLabel: 'Terlaris',
    alamat: 'Jl. Buahbatu No.45, Kota Bandung, Jawa Barat',
    kecamatan: 'Buahbatu',
    jadwal: 'Sabtu • 09:30 - 11:00 WIB',
    durasiSesi: '1 Sesi = 90 Menit',
    deskripsi:
        'Studio seni anak usia dini yang memfasilitasi kegiatan menggambar, mewarnai, melukis jari (finger painting), dan prakarya sensorik dengan cat non-toksik yang aman bagi balita.',
    rentangUsia: '2-5 tahun',
    usiaMin: 2,
    usiaMax: 5,
    imageUrl:
        'https://images.unsplash.com/photo-1513364776144-60967b0f800f?auto=format&fit=crop&w=800&q=80',
    themeColorHex: '#F59E0B',
    fasilitas: [
      FasilitasItem(nama: 'Cat Non-Toksik', iconKey: 'palette'),
      FasilitasItem(nama: 'Mentor Seni', iconKey: 'person'),
      FasilitasItem(nama: 'Area Tunggu', iconKey: 'weekend'),
      FasilitasItem(nama: 'Galeri Karya', iconKey: 'photo'),
      FasilitasItem(nama: 'Celemek Anak', iconKey: 'toys'),
    ],
    ulasan: [
      UlasanModel(
        namaOrangTua: 'Ibu Nadia',
        rating: 4.8,
        komentar:
            'Anakku betah banget mewarnai dan eksplorasi warna di sini. Pulang-pulang bawa hasil lukisan sendiri.',
      ),
    ],
    tagsCbf: [
      'Seni dan Kreativitas',
      'Menggambar dan mewarnai',
      'Melukis',
      'Kreatif dan bereksplorasi',
      'Tenang dan fokus',
      'Mengembangkan kreativitas',
      'Eksplorasi tekstur dan sensorik',
    ],
  ),
  KegiatanModel(
    id: 'keg-003',
    namaInstansi: 'Taman Edukasi Bandung',
    kategoriUtama: 'Playground',
    subJudul: 'Outdoor Playground & Motorik Kasar',
    harga: 50000,
    satuanHarga: '/Anak',
    rating: 4.7,
    jumlahUlasan: 156,
    badgeLabel: 'Terjangkau',
    alamat: 'Jl. Diponegoro No.12, Kota Bandung, Jawa Barat',
    kecamatan: 'Cibeunying',
    jadwal: 'Setiap Hari • 08:00 - 16:00 WIB',
    durasiSesi: '1 Sesi = 120 Menit',
    deskripsi:
        'Area bermain edukatif luar ruang dengan perosotan ramah balita, jembatan keseimbangan, bola warna-warni, dan permainan kelompok untuk melatih motorik kasar serta interaksi sosial anak.',
    rentangUsia: '1-5 tahun',
    usiaMin: 1,
    usiaMax: 5,
    imageUrl:
        'https://img.cnt.traveloka.com/tvlk/blog/2025/01/taman-bermain-mob.png',
    themeColorHex: '#10B981',
    fasilitas: [
      FasilitasItem(nama: 'Arena Outdoor', iconKey: 'park'),
      FasilitasItem(nama: 'Pengawas Area', iconKey: 'person'),
      FasilitasItem(nama: 'Gazebo Orang Tua', iconKey: 'weekend'),
      FasilitasItem(nama: 'Ruang Laktasi', iconKey: 'door'),
      FasilitasItem(nama: 'Permainan Bola', iconKey: 'toys'),
    ],
    ulasan: [
      UlasanModel(
        namaOrangTua: 'Ibu Sari',
        rating: 4.7,
        komentar:
            'Harga sangat terjangkau, tempat luas dan teduh. Bagus buat anak yang energinya banyak.',
      ),
    ],
    tagsCbf: [
      'Olahraga dan Gerak',
      'Bermain bola',
      'Aktif dan banyak bergerak',
      'Suka berinteraksi dan bekerja sama',
      'Mengembangkan kemampuan motorik',
      'Meningkatkan kemampuan sosial',
      'Motorik',
    ],
  ),
  KegiatanModel(
    id: 'keg-004',
    namaInstansi: 'Little Melody Studio',
    kategoriUtama: 'Musik & Tari',
    subJudul: 'Kelas Musik Ritmik & Tari Balita',
    harga: 120000,
    satuanHarga: '/Sesi',
    rating: 4.9,
    jumlahUlasan: 78,
    badgeLabel: 'Terpopuler',
    alamat: 'Jl. Ir. H. Juanda (Dago) No.88, Kota Bandung',
    kecamatan: 'Dago',
    jadwal: 'Minggu • 10:00 - 11:00 WIB',
    durasiSesi: '1 Sesi = 60 Menit',
    deskripsi:
        'Program stimulasi musikal dan gerak tari untuk anak usia dini. Anak diajak bernyanyi, mengenal alat musik perkusi ringan, dan menari bersama teman sebaya.',
    rentangUsia: '2-5 tahun',
    usiaMin: 2,
    usiaMax: 5,
    imageUrl:
        'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?auto=format&fit=crop&w=800&q=80',
    themeColorHex: '#8B5CF6',
    fasilitas: [
      FasilitasItem(nama: 'Alat Musik Anak', iconKey: 'music'),
      FasilitasItem(nama: 'Studio Akustik', iconKey: 'person'),
      FasilitasItem(nama: 'Area Tunggu', iconKey: 'weekend'),
      FasilitasItem(nama: 'Lantai Matras', iconKey: 'door'),
      FasilitasItem(nama: 'Kostum Tari', iconKey: 'toys'),
    ],
    ulasan: [
      UlasanModel(
        namaOrangTua: 'Ibu Maya',
        rating: 4.9,
        komentar:
            'Anak saya jadi lebih percaya diri tampil dan senang bernyanyi di rumah setelah ikut kelas ini.',
      ),
    ],
    tagsCbf: [
      'Musik dan Tari',
      'Bernyanyi',
      'Bermain alat musik',
      'Menari',
      'Suka berinteraksi dan bekerja sama',
      'Meningkatkan kemampuan sosial',
      'Mengembangkan kreativitas',
    ],
  ),
  KegiatanModel(
    id: 'keg-005',
    namaInstansi: 'SmartKids Montessori',
    kategoriUtama: 'Kognitif & Bahasa',
    subJudul: 'Stimulasi Kognitif, Puzzle & Sensorik',
    harga: 135000,
    satuanHarga: '/Sesi',
    rating: 4.8,
    jumlahUlasan: 112,
    badgeLabel: 'Rekomendasi',
    alamat: 'Jl. L.L.R.E. Martadinata (Riau) No.40, Kota Bandung',
    kecamatan: 'Riau',
    jadwal: 'Sabtu • 10:00 - 11:30 WIB',
    durasiSesi: '1 Sesi = 90 Menit',
    deskripsi:
        'Kelas berbasis metode Montessori untuk melatih fokus, mengenal huruf dan angka, bermain puzzle kayu, membaca cerita interaktif, serta kemandirian sehari-hari.',
    rentangUsia: '1-5 tahun',
    usiaMin: 1,
    usiaMax: 5,
    imageUrl:
        'https://images.unsplash.com/photo-1587654780291-39c9404d746b?auto=format&fit=crop&w=800&q=80',
    themeColorHex: '#0EA5E9',
    fasilitas: [
      FasilitasItem(nama: 'Apparatus Montessori', iconKey: 'puzzle'),
      FasilitasItem(nama: 'Fasilitator Anak', iconKey: 'person'),
      FasilitasItem(nama: 'Pojok Baca', iconKey: 'weekend'),
      FasilitasItem(nama: 'Ruang AC Nyaman', iconKey: 'door'),
      FasilitasItem(nama: 'Kit Sensorik', iconKey: 'toys'),
    ],
    ulasan: [
      UlasanModel(
        namaOrangTua: 'Ibu Clara',
        rating: 4.8,
        komentar:
            'Pendekatannya sangat tenang dan terstruktur. Anak belajar merapikan mainan sendiri dan cepat hafal huruf.',
      ),
    ],
    tagsCbf: [
      'Kognitif dan Bahasa',
      'Keterampilan Sehari-hari dan Sensorik',
      'Membaca cerita',
      'Belajar mengenal huruf dan angka',
      'Bermain puzzle',
      'Eksplorasi tekstur dan sensorik',
      'Tenang dan fokus',
      'Melatih kemampuan berpikir dan bahasa',
      'Melatih kemandirian',
    ],
  ),
];
