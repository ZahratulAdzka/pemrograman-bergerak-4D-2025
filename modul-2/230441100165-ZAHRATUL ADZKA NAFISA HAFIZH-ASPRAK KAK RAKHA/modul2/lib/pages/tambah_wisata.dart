import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class TambahWisata extends StatefulWidget {
  const TambahWisata({super.key});

  @override
  _TambahWisataState createState() => _TambahWisataState();
}

class _TambahWisataState extends State<TambahWisata> {
  File? _image;
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _lokasiController = TextEditingController();
  final _hargaController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String? _jenisWisata;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _validateForm() {
    if (_image == null) {
      _showSnackbar('Silakan upload gambar wisata');
      return;
    }
    if (_formKey.currentState!.validate()) {
      if (_jenisWisata == null) {
        _showSnackbar('Silakan pilih jenis wisata');
        return;
      }
      _showSnackbar('Semua data valid!');
    }
  }

  void _resetForm() {
    setState(() {
      _image = null;
      _jenisWisata = null;
    });
    _formKey.currentState?.reset();
    _namaController.clear();
    _lokasiController.clear();
    _hargaController.clear();
    _deskripsiController.clear();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: AppBar(
        title: const Text("Tambah Wisata"),
        centerTitle: true,
        backgroundColor: const Color(0xFF261FB3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  image: _image != null
                      ? DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _image == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 50, color: Colors.grey[600]),
                            const SizedBox(height: 8),
                            Text(
                              'Tambah Foto',
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF261FB3),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Upload Image', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 24),
              _buildLabel("Nama Wisata:"),
              TextFormField(
                controller: _namaController,
                validator: (value) => value == null || value.isEmpty ? 'Nama wisata wajib diisi' : null,
                decoration: _inputDecoration('Masukkan Nama Wisata Disini'),
              ),
              const SizedBox(height: 24),
              _buildLabel("Lokasi Wisata:"),
              TextFormField(
                controller: _lokasiController,
                validator: (value) => value == null || value.isEmpty ? 'Lokasi wajib diisi' : null,
                decoration: _inputDecoration('Masukkan Lokasi Wisata Disini'),
              ),
              const SizedBox(height: 24),
              _buildLabel("Jenis Wisata:"),
              DropdownButtonFormField<String>(
                value: _jenisWisata,
                decoration: _inputDecoration('Pilih Jenis Wisata'),
                items: [
                  'Pantai',
                  'Pegunungan',
                  'Kuliner',
                  'Taman Hiburan',
                  'Sejarah',
                ].map((jenis) => DropdownMenuItem(value: jenis, child: Text(jenis))).toList(),
                onChanged: (value) => setState(() => _jenisWisata = value),
              ),
              const SizedBox(height: 24),
              _buildLabel("Harga Tiket:"),
              TextFormField(
                controller: _hargaController,
                validator: (value) => value == null || value.isEmpty ? 'Harga tiket wajib diisi' : null,
                decoration: _inputDecoration('Masukkan Harga Tiket Disini'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 24),
              _buildLabel("Deskripsi:"),
              TextFormField(
                controller: _deskripsiController,
                validator: (value) => value == null || value.isEmpty ? 'Deskripsi wajib diisi' : null,
                decoration: _inputDecoration('Masukkan Deskripsi Wisata Disini'),
                maxLines: 6,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _validateForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF261FB3),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Simpan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: _resetForm,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.grey.shade400),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Reset', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}
