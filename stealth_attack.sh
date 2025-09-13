#!/bin/bash

# 🕶️ Launcher لتشغيل أدوات اختراق من داخل بيئة مجهولة (Tor + Proxychains + Firejail)

# التأكد من تشغيل Tor
systemctl start tor >/dev/null 2>&1

echo " "
echo "🛡️ تشغيل أدوات اختبار الاختراق في بيئة مجهولة"
echo "--------------------------------------------"
echo "اختر أداة للعمل من خلال القائمة:"
echo "1. Nmap"
echo "2. sqlmap"
echo "3. Nikto"
echo "4. Curl (مع user-agent مزيف)"
echo "5. Exit"
echo " "

read -p "➤ اختيارك (رقم): " option

case $option in
  1)
    read -p "📌 أدخل الهدف (مثلاً: target.com): " target
    echo "[+] فتح Nmap عبر Tor وProxychains..."
    proxychains firejail nmap -sT -Pn $target
    ;;
  2)
    read -p "📌 أدخل رابط موقع أو صفحة بها باراميتر: " url
    echo "[+] فتح sqlmap عبر Tor وProxychains..."
    proxychains firejail sqlmap -u "$url" --batch --tor --tor-type=SOCKS5 --check-tor
    ;;
  3)
    read -p "📌 أدخل رابط الهدف (مثلاً: http://target.com): " url
    echo "[+] فتح Nikto عبر Tor وProxychains..."
    proxychains firejail nikto -h "$url"
    ;;
  4)
    read -p "📌 أدخل رابط: " url
    echo "[+] فتح curl باستخدام User-Agent مزيف عبر Tor..."
    proxychains firejail curl -A "Mozilla/5.0 (X11; Linux x86_64)" "$url"
    ;;
  5)
    echo "👋 إنهاء الجلسة. بالتوفيق."
    exit 0
    ;;
  *)
    echo "❌ اختيار غير صالح."
    ;;
esac
