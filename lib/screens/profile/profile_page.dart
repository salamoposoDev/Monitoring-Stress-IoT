import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade700,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          'https://images.pexels.com/photos/17522554/pexels-photo-17522554/free-photo-of-face-of-man-in-eyeglasses-in-darkness.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Fadel Shubair',
                        style: GoogleFonts.poppins(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '"Rancang Bangun Alat Deteksi Stres Bebasis AIoT"',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade300),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Text(
                        '''Aplikasi monitoring stres ini dibuat dengan tujuan utama untuk membantu pengguna memantau tingkat stres mereka berdasarkan data detak jantung secara real-time. Aplikasi ini dirancang untuk mendeteksi dan mengklasifikasikan kondisi stres seperti rileks, tenang, cemas, dan tegang, sehingga pengguna dapat lebih memahami dan mengelola stres mereka secara efektif. 
                        
Dengan aplikasi ini, pengguna dapat melakukan pemantauan rutin, mendapatkan notifikasi ketika tingkat stres meningkat, dan mengambil langkah-langkah yang diperlukan untuk menjaga keseimbangan mental dan fisik.
                  ''',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
