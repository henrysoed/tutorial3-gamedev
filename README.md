# Tutorial 3

Pada tutorial 3 ini, saya membuat sebuah 2D platformer character controller sederhana yang ditulis menggunakan Godot Engine. Kode awal yang digunakan memiliki struktur dasar untuk menangani:
- Karakter: Menggunakan CharacterBody2D sebagai node utama.
- Gerakan Horizontal: Mengubah velocity.x berdasarkan input kiri/kanan.
- Lompatan Dasar: Mengatur velocity.y ketika tombol loncat (ui_up) ditekan, dibantu oleh fungsi is_on_floor() untuk mendeteksi apakah karakter berada di lantai.
- Proses Fisika: Menggunakan _physics_process(delta) untuk mengatur pergerakan karakter setiap frame, termasuk pemanggilan move_and_slide() agar karakter dapat bergerak dan bertabrakan dengan benar.

Selanjutnya, saya membuat tiga fitur tambahan berikut sebagai latihan mandiri:
1. Double Jump
2. Dash
3. Crouch

## Fitur-Fitur Tambahan
### 1. Double Jump
Double Jump adalah kemampuan karakter untuk melompat dua kali sebelum menyentuh lantai.
#### Cara Kerja
- Variabel max_jumps menentukan berapa kali karakter dapat melompat sebelum menyentuh lantai.
- Saat tombol loncat (ui_up) ditekan, dicek apakah karakter sedang di lantai atau apakah jump_count masih di bawah max_jumps.
- Jika syarat terpenuhi, velocity.y diset ke jump_speed dan jump_count ditambah.
- Saat karakter kembali menyentuh lantai, jump_count di-reset menjadi 0.

### 2. Dash
Dash adalah gerakan cepat ke arah tertentu (kiri atau kanan) dalam durasi singkat.
#### Cara Kerja
- Memanfaatkan double-tap pada tombol arah (left/right).
- Menggunakan Time.get_ticks_msec() untuk mendeteksi interval waktu antara dua kali penekanan tombol.
- Jika interval kurang dari double_tap_threshold, maka fungsi start_dash(direction) dipanggil.
- start_dash(direction) akan mengatur is_dashing menjadi true, memberi boost kecepatan pada velocity.x, serta mengatur timer untuk durasi dash (dash_duration).
- Setelah dash selesai, ada cooldown (dash_cooldown) sebelum dash dapat digunakan kembali.

### 3. Crouch
Crouch adalah aksi jongkok yang membuat karakter bergerak lebih lambat dan tampilan (animasi) berubah.
#### Cara Kerja
- Jika tombol ui_down ditekan, is_crouching akan diset ke true.
- Kecepatan berjalan (walk_speed) diganti menjadi crouch_speed.
- Animasi karakter diubah menjadi animasi jongkok (misal: $AnimatedSprite2D.play("crouching")).
- Saat tombol dilepas, karakter kembali ke posisi dan animasi normal (idle), dan walk_speed dikembalikan ke normal_speed.

## Cara Menggunakan
### 1. Double Jump
- Tekan ui_up (panah atas atau tombol yang ditetapkan) untuk lompat.
- Tekan lagi ui_up di udara sebelum menyentuh lantai untuk loncatan kedua.
### 2. Dash
- Tekan tombol arah (left/right) dua kali dengan cepat untuk melakukan dash.
- Dash berlangsung singkat dan memiliki cooldown sebelum bisa digunakan lagi.
### 3. Crouch
- Tekan ui_down (panah bawah atau tombol yang ditetapkan) untuk jongkok.
- Saat jongkok, karakter bergerak lebih lambat dan animasinya berubah.
- Lepaskan tombol untuk kembali ke posisi berdiri normal.

Referensi gambar yang saya gunakan : https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pngwing.com%2Fen%2Ffree-png-nlzww&psig=AOvVaw16d0ybYXTjwB9hlrjcyxbN&ust=1740814457046000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCOCVwKzt5YsDFQAAAAAdAAAAABAE