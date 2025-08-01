# MANO-vhdl
FPGA implementation with mano architecture VHDL / Mano mimarisi, VHDL ile FPGA uygulaması

# Basic Computer on FPGA (with PS/2 Keyboard Input)  
# FPGA Üzerinde Temel Bilgisayar (PS/2 Klavye Girişli)

This project implements a simplified version of a basic computer system using VHDL on a Spartan-3E FPGA board.  
Bu proje, Spartan-3E FPGA kartı üzerinde VHDL ile yazılmış basit bir bilgisayar mimarisinin sadeleştirilmiş bir versiyonunu uygular.

It includes memory, a PS/2 keyboard interface, interrupt mechanism, and a 4-digit 7-segment display.  
Projede bellek, PS/2 klavye arayüzü, kesme (interrupt) mekanizması ve 4 haneli 7 segment display bulunmaktadır.

---

## 🧰 Tools & Technologies / Araçlar ve Teknolojiler

- **HDL Language / Donanım Tanımlama Dili:** VHDL  
- **FPGA Board / FPGA Kartı:** Digilent Spartan-3E (XC3S100E-4CP132C)  
- **Clock Frequency / Saat Frekansı:** 50 MHz  
- **IDE / Geliştirme Ortamı:** Xilinx ISE 14.7  
- **Input Device / Giriş Aygıtı:** PS/2 Klavye  
- **Display / Görüntüleme:** 4 haneli 7 segment display  
- **Simulation / Simülasyon:** ISim

---

## 📁 Project Structure / Proje Yapısı

```
BasicComputer_FPGA/
├── ps2_keyboard_to_ascii/      # PS/2 tarama kodunu ASCII'ye çeviren modül
├── memory2.vhd                 # Talimat/veri belleği (RAM)
├── Display.vhd                 # 7 segment display sürücüsü
├── clock_divider_1hz.vhd      # 50 MHz'den 1 Hz'e saat bölücü
├── BasicComputer.vhd          # Ana bilgisayar mimarisi ve kontrol mantığı
├── testbenches/               # (opsiyonel) Simülasyon testbench'leri
└── README.md
```

---

## 🔑 Features / Özellikler

- **PS/2 Keyboard Input / Klavye Girişi:** Klavyeden gelen PS/2 sinyallerini ASCII'ye çevirir ve yeni veri geldiğinde FGI bayrağını set eder.  
- **Interrupt Handling / Kesme Yönetimi:** PC yedeği alarak kesme alt programı çalıştırır ve geri döner.  
- **Memory-Mapped I/O / Bellek Haritalı G/Ç:** INPR ve OUTR üzerinden giriş/çıkış işlemleri yapılır.  
- **7-Segment Display / 7 Segment Gösterim:** Instruction Register (`IR`) anlık olarak ekranda gösterilir.  
- **Clock Divider / Saat Bölücü:** 1 Hz sinyal üretir, özellikle yavaş izleme veya debugging için kullanılır.  
- **Instruction Set / Komut Seti:** AND, ADD, LDA, STA, BUN, BSA, ISZ ve kayıt işlemleri desteklenir.

---

## ⌨️ PS/2 Interface / PS/2 Arayüzü

The `ps2_keyboard_to_ascii` component reads raw scan codes from the keyboard and outputs 7-bit ASCII characters.  
`ps2_keyboard_to_ascii` bileşeni klavyeden gelen PS/2 sinyallerini okur ve 7-bit ASCII karakter üretir.

```vhdl
ascii_new  : out std_logic;                -- new character flag / yeni karakter geldi bayrağı
ascii_code : out std_logic_vector(6 downto 0); -- 7-bit ASCII output / 7-bit ASCII çıktısı
```

When a new key is pressed, `ascii_new` goes high and the ASCII character is stored in `INPR`.  
Yeni bir tuşa basıldığında `ascii_new` yükselir ve ASCII karakter `INPR`'ye yazılır.

---

## 🔄 Instruction Cycle / Komut Döngüsü

The system follows a classic fetch-decode-execute cycle controlled by a 4-bit `timeCount`.  
Sistem, klasik bir komut alma-çözme-çalıştırma döngüsünü 4-bit `timeCount` ile yönetir.

It supports both direct and indirect addressing.  
Doğrudan ve dolaylı adreslemeyi destekler.

---

## 📷 Display Output / Ekran Çıkışı

The `Display.vhd` module multiplexes 4 digits of the 7-segment display to show the current 16-bit IR value.  
`Display.vhd` modülü 4 haneli 7 segment ekranı çoklayarak 16-bit IR değerini gösterir.

Each 4-bit nibble is shown for a short time to create the illusion of a stable display.  
Her 4-bit’lik nibble kısa süreyle gösterilir, bu da sabit bir görüntü sağlar.

---

## 🧪 Simulation / Simülasyon

Testbenches can be written to simulate each module using ISim.  
ISim ile her bileşen için testbench yazılarak simülasyon yapılabilir.

The `clock_divider_1hz` is helpful for slow step-by-step debugging.  
`clock_divider_1hz`, adım adım yavaş ilerleme için faydalıdır.

---

## ✅ To Do / Yapılacaklar

- [ ] Write testbenches for each component / Her bileşen için testbench yaz  
- [ ] Add UART or VGA support / UART veya VGA desteği ekle  
- [ ] Expand instruction set / Komut setini genişlet  

---

## 📜 License / Lisans

This project is open-source and free to use for educational or personal purposes.  
Bu proje açık kaynaklıdır ve eğitim veya kişisel kullanım için serbesttir.

---

Created by [Esmanur MAHMUT] – 2025  
[Esmanur MAHMUT] tarafından oluşturuldu – 2025
