# ZADÁNÍ

1) Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2) Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3) Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4) Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5) Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

# HYPOTÉZY

AD 1) Mzdy ve všech odvětvích v průběhu let rostou.
AD 2) Průměrná mzda roste rychleji, než cena základních potravin, jako jsou chléb a mléko, je tedy možné v posledním srovnatelném období (2018) koupit větší množství těchto potravin, než dříve (2006).
AD 3) Nejpomaleji zdražuje mouka.
AD 4) Ano, existuje.
AD 5) Ano, myslím si, že růst cen potravin a mezd "kopíruje" meziroční vývoj HDP.


# POSTUP

## VYTVOŘENÍ PRIMÁRNÍ A SEKUNDÁRNÍ TABULKY
Nejprve jsem si vytvořila primární tabulku, a to tak, aby zahrnovala všechna data, která budu nadále potřebovat k zodpovězení výzkumných otázek. Toho jsem dosáhla tak, že jsem si z dostupných tabulek vybrala ty, které tyto data zahrnují, spojila je na základě stejného sloupce pro rok (u tabulky czechia_price bylo potřeba nejprve extrahovat rok ze sloupce obsahujícího datum) a k tomu připojila i "vysvětlující" sloupce z dvou dalších tabulek, aby bylo vidět, co za odvětví a kategorii potravin se skrývá pod dostupnými kódy. Data jsem ještě omezila (klauzulí WHERE) tak, abych z tabulky pro mzdy dostala pouze data pro prům.hrubou mzdu (a ne prům.počet zaměstnaných osob), tedy hodnoty v Kč (ne tis.osob), a zajímal mě přepočtený (nikoliv fyzický) stav, který by měl dávat reálnější výsledky. 
Pro vytvoření sekundární tabulky bylo potřeba spojit tabulky countries a economies, což se mi podařilo na základě společného sloupce pro "country" a zajímaly mě pouze evropské země  pouze za stejné (srovnatelné) období, jako předchozí data pro ČR, takže jsem si data této sekundární tabulky ještě zúžila klauzulí WHERE.

## VYTVOŘENÍ SADY SQL K ZODPOVĚZENÍ OTÁZEK
AD 1) Pro zodpovězení otázky bylo potřeba zjistit průměrnou mzdu v jednotlivých letech pro jednotlivá odvětví a vytvořit dodatečný sloupec (pomocí CASE), který bude na základě vypočtených průměrů informovat o nárůstu/poklesu mezd v porovnání s předešlým rokem.
AD 2) Zde jsem postupovala tak, že jsem si zjistila průměrné mzdy a průměrné ceny pro jednotlivé kategorie potravin (mléko a chléb) v prvním (MIN) a posledním (MAX) srovnatelném období a tyto dvě čísla mezi sebou vydělila (mzdy/ceny), abych zjistila, jaké množství těchto potravin bylo možné za danou mzdu pořídit.
AD 3) Abych zjistila, která potravina zdražuje nejpomaleji, musela jsem zjistit průměrné ceny daných kategorií v jednotlivých letech a jejich procentuální růst/pokles. Výsledky jsem seřadila, abych na prvním řádku měla nejnižší nárůst (potravinu, která roste nejpomaleji).
AD 4) Zde bylo potřeba využít průměrné ceny potravin a průměrné mzdy (seskupené pro jednotlivé roky) a jejich procentuální meziroční nárůst/pokles, abych následně mohla pomocí CASE expression vytvořit pomocný sloupec, ve kterém zhodnotím, zda se jedná o výrazný rozdíl (alespoň 10%) mezi procentuálním meziročním nárůstem cen vůči procentuálnímu meziročnímu nárůstu mezd, či nikoliv.
AD 5) K vypozorování vztahu mezi mírou růstu/poklesu HDP a mezd/potravin jsem opět pracovala s průměrnými hodnotami sledovaných údajů a jejich meziročním rozdílem.

# VÝSLEDKY

AD 1) Mzdy ve všech odvětvích zpravidla meziročně rostou. Dodatečně jsem si dopočítala počet let, kdy docházelo k poklesu, za každé odvětví, a zjistila jsem, že ze sledovaného období (13 let) došlo nejčastěji (4x) k poklesu mezd v odvětví "Těžba a dobývání". Naopak ani 1x nedošlo k poklesu v odvětvích "Zdravotní a sociální péče", "Zpracovatelský průmysl" a "Ostatní činnosti". Pro zajímavost jsem ještě hledala, ve kterém roce došlo k poklesu mezd (napříč odvětvími) nejčastěji, a zjistila jsem, že až 11x (tedy u 11 odvětví) to bylo v roce 2013.
AD 2) V posledním srovnatelném období (2018) je možné si koupit více kilogramů chleba a litrů mléka, než v roce 2006. Konkrétně: V roce 2006 si šlo koupit téměř 1466 litrů mléka, oproti necelým 1670 litrům v roce 2018 (rozdíl cca 14%). Chleba se dalo z průměrné mzdy koupit v roce 2006 1312 kg a v roce 2018 1365 kg (rozdíl cca 4%).
AD 3) Dle mých výsledků všechny potraviny zdražují. Nejpomaleji zdražuje bílé víno, a to o 8,3% (pro srovnání: nejrychleji zdražuje máslo, konkrétně o 115,5%). Víno mě jako výsledek překvapilo, a tak jsem si ještě prověřila, jakou cenu mělo víno v prvním porovnatelném období, a zjistila jsem, že pro víno existují ceny pouze za poslední 4 srovnatelné roky (2015-2018). Myslím, že by tato skutečnost mohla mít na výsledek vliv.
AD 4) Takový rok neexistuje. Nejvyšší rozdíl vidím v r. 2009, kde je téměř 10% (průměrná cena potravin se procentuálně snížila o 6,79%, zatímco průměrná mzda vzrostla o 3,07%.
AD 5) Z výsledků vyplývá, že není pravidlem, že by se nárůst/pokles HDP projevil stejným směrem i na cenách potravin či výši mezd.


# KONTAKT

V případě jakýchkoliv dotazů či poskytnutí zpětné vazby mě, prosím, kontaktujte přes Discord: sonja_42224
