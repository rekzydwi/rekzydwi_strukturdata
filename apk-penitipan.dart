import 'dart:io';

class Barang {
  int nomor;
  String namaBarang;
  String deskripsi;
  bool sudahDiambil;

  Barang(this.nomor, this.namaBarang, this.deskripsi, {this.sudahDiambil = false});
}

class Node<T> {
  T data;
  Node<T>? next;
  
  Node(this.data);
}

class Stack<T> {
  Node<T>? atas;
  int panjang = 0;

  void push(T element) {
    var newNode = Node<T>(element);
    newNode.next = atas;
    atas = newNode;
    panjang++;
  }

  T? pop() {
    if (atas == null) return null;
    var result = atas!.data;
    atas = atas!.next;
    panjang--;
    return result;
  }

  T? get peek => atas?.data;
  bool get isEmpty => panjang == 0;
  int get length => panjang;
}

class Penitipan {
  List<Barang> daftarBarang = [];
  List<Barang> antrianBarang = [];
  Stack<Barang> riwayatBarang = Stack<Barang>();
  int nomorBerikutnya = 1;

  void titipkanBarang(String namaBarang, String deskripsi) {
    var barang = Barang(nomorBerikutnya, namaBarang, deskripsi);
    daftarBarang.add(barang);
    antrianBarang.add(barang);
    print('Barang berhasil dititipkan dengan nomor: ${barang.nomor}');
    nomorBerikutnya++;
  }

  void ambilBarang(int nomor) {
  var barang = daftarBarang.firstWhere((barang) => barang.nomor == nomor);
  if (barang != null) {
    if (!barang.sudahDiambil) {
      barang.sudahDiambil = true;
      riwayatBarang.push(barang);
      print('Barang dengan nomor $nomor berhasil diambil.');
    } else {
      print('Barang dengan nomor $nomor sudah diambil sebelumnya.');
    }
  } else {
    print('Barang dengan nomor $nomor tidak ditemukan.');
  }
}

  void lihatStatusBarang() {
    if (daftarBarang.isEmpty) {
      print('Tidak ada barang yang dititipkan.');
    } else {
      print('Daftar barang yang dititipkan:');
      for (var barang in daftarBarang) {
        print('Nomor: ${barang.nomor}, Nama: ${barang.namaBarang}, Deskripsi: ${barang.deskripsi}, Sudah diambil: ${barang.sudahDiambil ? "Sudah" : "Belum"}');
      }
    }
  }

  void lihatBarangDititipkan() {
    if (antrianBarang.isEmpty) {
      print('Tidak ada barang dalam daftar.');
    } else {
      print('Daftar barang yang dititipkan:');
      for (var barang in antrianBarang) {
        print('Nomor: ${barang.nomor}, Nama: ${barang.namaBarang}, Deskripsi: ${barang.deskripsi}');
      }
    }
  }

  void lihatRiwayatBarang() {
    if (riwayatBarang.isEmpty) {
      print('Tidak ada riwayat barang yang diambil.');
    } else {
      print('Riwayat barang yang diambil:');
      for (var barang = riwayatBarang.atas; barang != null; barang = barang.next) {
        print('Nomor: ${barang.data.nomor}, Nama: ${barang.data.namaBarang}, Deskripsi: ${barang.data.deskripsi}');
      }
    }
  }
}

void main() {
  Penitipan titip = Penitipan();
  while (true) {
    print('\nManajemen Penitipan Barang');
    print('1. Masukkan Barang');
    print('2. Ambil Barang');
    print('3. Lihat Status Barang');
    print('4. Lihat Barang Yang Dititipkan');
    print('5. Lihat Riwayat Barang');
    print('6. Keluar');
    stdout.write('Pilih opsi: ');
    var input = stdin.readLineSync();

    switch (input) {
      case '1':
        stdout.write('Masukkan Nama Barang: ');
        var namaBarang = stdin.readLineSync();
        stdout.write('Masukkan Deskripsi Barang: ');
        var deskripsi = stdin.readLineSync();
        if (namaBarang != null && namaBarang.isNotEmpty && deskripsi != null && deskripsi.isNotEmpty) {
          titip.titipkanBarang(namaBarang, deskripsi);
        } else {
          print('Nama atau Deskripsi Barang tidak boleh kosong.');
        }
        break;
      case '2':
        stdout.write('Masukkan Nomor Barang Yang Akan Diambil: ');
        var nomorIn = stdin.readLineSync();
        if (nomorIn != null && int.tryParse(nomorIn) != null) {
          var nomor = int.parse(nomorIn);
          titip.ambilBarang(nomor);
        } else {
          print('Nomor barang tidak valid.');
        }
        break;
      case '3':
        titip.lihatStatusBarang();
        break;
      case '4':
        titip.lihatBarangDititipkan();
        break;
      case '5':
        titip.lihatRiwayatBarang();
        break;
      case '6':
        exit(0);
      default:
        print('Opsi tidak valid.');
    }
  }
}