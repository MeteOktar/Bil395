# README - Lex & Yacc Calculator
Mete Oktar 231101034
Bu odevde Lex ve Yacc kullanarak basit bir hesap makinesi yorumlayicisi (interpreter) yaptim. Program hem dort islem yapabiliyor, hem de degisken tanimlamayi destekliyor (odevde buna dair bir gereklilik gormedim ama denemek istedim, pek basarili olamadim gibi duruyor). Ayrica float (ondalikli) sayilar ve parantezli islemler de yapilabiliyor (bonus icin).    

---

Tasarim Kararlari

- Sayilari, operatorleri, parantezleri ve degisken isimlerini tanimak icin Lex kullandim.
- Sayilar float olarak islensin diye hem tam sayi hem de ondalikli sayi desenleri tanimladim.
- Yacc kismina grammar kurallarini yazdim. Toplama, cikarma, carpma, bolme ve us alma (`^`) islemleri var.
- Degisken tanimlamak icin `x = 5` gibi atamalar yapilabiliyor. Daha sonra `x + 3` gibi kullanilabiliyor. (niyetim buydu cok calisiyor gibi durmuyor)
- Bolme islemi yapilirken sifira bolunurse hata veriyor ama "Result" yazmiyor.
- Tanimsiz degisken kullanilirsa, kullaniciya uyari veriliyor ve degeri 0 olarak aliniyor.

---

Uygulama Adimlari

1. Ilk olarak Lex dosyasini (`calculator.l`) yazdim. Token'lari tanimladim:
   - Sayilar (float da dahil)
   - `+ - * / ^` operatorleri
   - Parantezler
   - Degisken isimleri (harfler)
   - Atama icin `=`

2. Sonra Yacc dosyasini (`calculator.y`) yazdim:
   - Grammar kurallarini yazdim (`expr`, `stmt` vs.)
   - Her islem icin islem sonucunu hesaplayan C kodlari yazdim
   - `^` islemi icin `pow()` fonksiyonunu kullandim (math.h kutuphanesi)

3. Atama islemleri icin kucuk bir sembol tablosu (dizi) kullandim. Degisken adini ve degerini orada tuttum.

4. Bolme isleminde eger bolen 0 ise `yyerror()` fonksiyonu calisiyor ve `NAN` donduruluyor. Boylece "Result" yazilmiyor.

---

## Derleme ve Calistirma

```bash
lex calculator.l
yacc -d -o calculator.tab.c calculator.y
gcc lex.yy.c calculator.tab.c -o calculator -lm
./calculator