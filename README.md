# 🚀 Automated WordPress Setup on Ubuntu / LXC Proxmox

Repositori ini berisi sekumpulan script Bash modular yang dirancang untuk mempermudah dan mempercepat proses instalasi web server (LEMP Stack) serta WordPress pada OS Ubuntu/Debian, khususnya untuk lingkungan **LXC Container Proxmox**.

---

## 📌 Fitur & Modul Script

Repositori ini dibagi menjadi beberapa script modular agar dapat dijalankan sesuai dengan alur praktikum/ujian:

| File Script | Deskripsi & Fungsi |
| :--- | :--- |
| `php.sh` | Mengunduh repository update serta menginstal Nginx, MariaDB, PHP-FPM, dan modul pendukungnya. |
| `wordpress.sh` | Mengunduh paket WordPress terbaru, mengekstrak ke `/var/www/html/`, serta mengatur hak akses `www-data`. |
| `nginx.sh` | Mendeteksi versi PHP-FPM socket secara otomatis dan mengonfigurasi Server Block Nginx. |
| `full.sh` | Menjalankan seluruh alur instalasi dari awal hingga akhir secara otomatis (All-in-One). |

---

## 🛠️ Cara Penggunaan

### 1. Clone Repositori
Masuk ke terminal LXC / Ubuntu server kamu, lalu jalankan:

```bash
git clone [https://github.com/Epithap/php-ubuntu.git](https://github.com/Epithap/php-ubuntu.git)
cd php-ubuntu
chmod +x *.sh
