log using "C:\Users\Utente\Desktop\UNI\DEMOGRAFIA APPLICATA ALL'IMPRESA E AL MERCATO\progetto\log_progeto_demo_Pietro_Ruffo"
cd "C:\Users\Utente\Desktop\UNI\DEMOGRAFIA APPLICATA ALL'IMPRESA E AL MERCATO\progetto\dataset progetto\INTEG2GEN_2015_IT_STATA\MICRODATI"
use INTEG2GEN_A2015.dta

set more off
***CODIFICA VARIABILI***

*LA TUA STORIA

*almeno un genitore straniero
gen almeno_un_gen_str=0
replace almeno_un_gen_str=1 if e2!="1"| e3!="1"

*tutti e due i gen italiani
gen gen_ita=0
replace gen_ita=1 if e2=="1" & e3=="1"

*entrambi i gen stranieri
gen gen_str=0
replace gen_str=1 if e2!="1"& e3!="1"
tab gen_str

***concentriamoci con i ragazzi con  un background migratorio
drop if gen_ita==1
*scuola superiore
gen scuola_sup=0
replace scuola_sup=1 if tiposcuola=="2"
****concencentriamoci solo sui ragazz delle superiori
drop if scuola_sup==0

*sesso
gen donna=0
replace donna=1 if a1=="2"
*cittadinanza (1 se cittadino 0 altrimenti)
gen cittadinanza=0
replace cittadinanza=1 if cittad=="1"
*nat* in italia
gen nato_ita=0
replace nato_ita=1 if a3=="1"
*ti senti italiano o straniero
gen sentirsi_ita=0
replace sentirsi_ita=1 if a11=="1"
*in futuro restare in italia
gen futuro_in_ita=0
replace futuro_in_ita=1 if a10_b_1=="1"| a10_a_1=="1"

*CONOSCENZA ED USO DELLA LINGUA ITALIANA

*focalizziamoci sulle competenze attive della lingua, che presuppongono un dominio delle passive (capire, leggere)
*parlare italiano bene
gen parlarebene=0
replace parlarebene=1 if b1_2=="4"| b1_2=="5"
*scrivere italiano bene
gen scriverebene=0
replace scriverebene=1 if b1_4=="4"| b1_4=="5"
*pensa in italiano
gen pensa_ita=0
replace pensa_ita=1 if b3_1b=="1"

*LA SCUOLA, GLI INSEGNANTI E I COMPAGNI

*rendimento scolastico percepito
gen rend_perc_male=0
replace rend_perc_male=1 if c8=="4"
*proxy rendimento effettivo, droppo i missing perché alcuni non hanno ancora la pagella
*matematica
drop if c9_a=="99"
gen mate_insuf=0
replace mate_insuf=1 if c9_a<="05"
*italiano
drop if c9_b=="99"
gen ita_male=0
replace ita_male=1 if c9_b<="05"
*bocciato almeno una volta
gen bocciato=0
replace bocciato=1 if c10!="1"
*aiuto compiti a casa
gen aiuto_compiti=0
replace aiuto_compiti=1 if c11_a_1!="1"
*esce con compagni
gen esce_con_compagni=0
replace esce_con_compagni=1 if c13=="2"
*lavoretti
gen lavoretti_frequenti=0
replace lavoretti_frequenti=1 if c21=="1"|c21=="2"
*pensa che solo ricchi e raccomandati vanno avanti
gen crede_raccomandati=0
replace crede_raccomandati=1 if c22_5=="5"
*intenzioni post scuola superiore, solo per ragazzi delle superiori
*lavorare
gen lavorare=0
replace lavorare=1 if (c19_a_1=="1" | c19_a_1=="2") 
*studiare, includo anche quelli che hanno risposto altro perché comunque faranno qualcosa e la modalità "Proseguire gli studi all'università" è la più numerosa
gen studiare=0
replace studiare=1 if (c19_a_1=="3"| c19_a_1=="6")
*NEET, includo anche gli indecisi
gen neet_risk=0
replace neet_risk=1 if (c19_a_1=="4"| c19_a_1=="5") 
*iniziato le scuole tardi: tra la prima media e il quinto superiore
gen inizio_scuola_tardi=0
replace inizio_scuola_tardi=1 if c6>="07" & c6<="14" 

*IL TEMPO LIBERO E GLI AMICI

*bullismo, almeno una volta
gen bullying=0
replace bullying=1 if d9_2!="5"|d9_13!="5"| d9_14!="5"| d9_9!="5"| d9_10!="5"| d9_5!="5"| d9_6!="5"| d9_1!="5"| d9_3!="5"| d9_4!="5"| d9_7!="5"| d9_8!="5"| d9_11!="5"| d9_12!="5"
*bullismo, tutti i giorni
gen bullying_everyday=0
replace bullying_everyday=1 if d9_2=="1"|d9_13=="1"| d9_14=="1"| d9_9=="1"| d9_10=="1"| d9_5=="1"| d9_6=="1"| d9_1=="1"| d9_3=="1"| d9_4=="1"| d9_7=="1"| d9_8=="1"| d9_11=="1"| d9_12=="1"
*bullissmo, spesso
gen bullying_often=0
replace bullying_often=1 if (d9_2!="5" & d9_2!="1")|(d9_13!="5" & d9_13!="1")|( d9_14!="5" &  d9_14!="1")|(d9_9!="5" & d9_9!="1")|(d9_10!="5" & d9_10!="1")|(d9_5!="5" & d9_5!="1")|(d9_6!="5"& d9_6!="1")|(d9_1!="5" & d9_1!="1")|(d9_3!="5" & d9_3!="1")| ( d9_4!="5" &  d9_4!="1")|( d9_7!="5" &  d9_7!="1")| (d9_8!="5" & d9_8!="1")|(d9_11!="5" & d9_11!="1")|(d9_12!="5" & d9_12!="1")
*uso molto internet: navigare in internet più di 2 ore al giorno oppure usa internet tutti i giorni per svolgere le attività elencate nel questionario alla domanda D.8
gen uso_molto_internet=0
replace uso_molto_internet=1 if d5_1=="5"| d8_3=="1"| d8_4=="1"| d8_9=="1"| d8_8=="1"| d8_7=="1"| d8_5=="1"| d8_2=="1"| d8_1=="1"| d8_6=="1"
*sport
gen sport=0
replace sport=1 if d6=="2"
*amici italiani: i compagni di scuola che incontra fuori dall'orario scolastico e gli amici sono italiani oppure italiani e stranieri (solo per ragazzi con cittadinanza) oppure 
*le var contrassegnate dalla lettera c sono per i compagni di scuola (una per i ragazz* con cittadinanza e una senza) mentre quelle contrassegnate dalla d fanno riferimento agli amici al di fuori della scuola 
gen amici_italiani=0
replace amici_italiani=1 if c13_a_1=="1"| c13_b!="2"|d2_a=="1"|d2_a=="3"|d2_1=="1"
*esce poco o nulla: vede gli amici meno di 4 volte al mese, poche volte l'anno oppure mai
gen esce_poco=0
replace esce_poco=1 if d1>="4"

*I TUOI GENITORI E LA TUA FAMIGLIA
*influenza dei genitori sulle amicizie
gen infl_gen_amicizie=0
replace infl_gen_amicizie=1 if d4!="1"
*vive con entrambi i genitori
gen vive_con_gen=0
replace vive_con_gen=1 if e1_a=="2" & e1_b=="2"
*vive solo con la madre
gen vive_solo_con_madre=0
replace vive_solo_con_madre=1 if e1_b=="2" & e1_a=="1" & e1_c=="1" & e1_f=="1" & e1_g=="1" & e1_h=="1" & e1_e=="1"
*fratelli/sorelle
gen frat_sor=0
replace frat_sor=1 if e1_e=="2" | e5=="2"
*almeno un genitore lavora
gen gen_lav=0
replace gen_lav=1 if e2_g=="2" |e3_g=="2"
*istruzione bassa madre
gen istr_bassa_mad=0
replace istr_bassa_mad=1 if e2_i <="3" | e2_i=="6"
*istruzione bassa padre
gen istr_bassa_pad=0
replace istr_bassa_pad=1 if e3_i <="3" | e3_i=="6"
*confronto con famiglia: se ha maturato la scelta di iscriversi in quella scuola superiore ascoltando la famiglia oppure se i genitori o i parenti hanno hanno influito molto sulla scelta (da 1 a 3 su una scala da 1 a 10 dove 1 è molto e 10  è per nulla)
gen confronto_con_famiglia=0
replace confronto_con_famiglia=1 if c2_a=="3"|c2_b_1<="03"|c2_b_2<="03"

*LA CASA E LA ZONA IN CUI VIVI

*pendolarismo, più di 30 min
gen scuola_lontana=0
replace scuola_lontana=1 if f11!="1" & f11!="2"
*ha una camera propria
gen cameretta=0
replace cameretta=1 if f4=="4"
*povertà estrema: senza gabinetto o senza acqua calda o senza doccia o senza riscaldamento
gen extr_pov=0
replace extr_pov=1 if f2_2=="1" | f2_3=="1" | f2_4=="1" | f2_6=="1"
*la famiglia possiede un pc
gen pc=0
replace pc=1 if f6_4=="2"
*vive in zona periferica (piccolo comune)
gen rural=0
replace rural=1 if grande_com=="0"

***GRAFICI***
*per realizzare i grafici sono state create le seguenti variabili
*nato in
gen nato_in=0
replace nato_in=1  if a4=="201"
replace nato_in=2  if a4=="235"
replace nato_in=3  if a4=="254"
replace nato_in=4  if a4=="436"
replace nato_in=8  if a4=="243"

*intenzioni
gen intenzioni=0
replace intenzioni=1 if (c19_a_1=="1" | c19_a_1=="2")
replace intenzioni=2 if (c19_a_1=="3"| c19_a_1=="6")
replace intenzioni=3 if (c19_a_1=="4"| c19_a_1=="5") 


***MODELLI LOGIT***

***MODELLI CON VAR RELATIVE ALLA SEZIONE "LA TUA STORIA"

*var altamente dipendenti tra loro, tengo solo cittadinanza
tab cittadinanza sentirsi_ita, chi2
tab cittadinanza futuro_in_ita, chi2 

*bullizzato almeno una volta
quietly logit studiare bullying donna, or r
quietly logit studiare bullying donna cittadinanza, or r
quietly logit studiare bullying donna cittadinanza nato_ita, or r
estimates store mod1

*bullizzato spesso
quietly logit studiare bullying_often donna, or r
quietly logit studiare bullying_often donna cittadinanza, or r
quietly logit studiare bullying_often donna cittadinanza nato_ita, or r
estimates store mod2

*bullizzato sempre
quietly logit studiare bullying_everyday donna, or r
quietly logit studiare bullying_everyday donna cittadinanza, or r
quietly logit studiare bullying_everyday donna cittadinanza nato_ita, or r
estimates store mod3

label var studiare "Iscriversi all'università"
label var donna "Essere donna"
label var cittadinanza "Avere la cittadinanza italiana"
label var nato_ita "Essere nati in Italia"
label var bullying "Bullizzati almeno una volta"
label var bullying_often "Bullizzati spesso"
label var bullying_everyday  "Bullizzati sempre"

esttab mod1 mod2 mod3,b(%9.3f) se(%9.3f) eform pr2 label nogaps order() star(+ 0.10 * 0.05 ** 0.01 *** 0.001) title("Essere vittime di bullismo e iscriversi all'università. Modelli Logit con variabili relative al vissuto degli studenti. 1=Bullizzati almeno una volta; 2=Bullizzati spesso; 3=Bullizzati sempre")

*tutte significative


*creo global "vissuto"
global vissuto "donna nato_ita cittadinanza"


***MODELLI CON VAR RELATIVE ALLA SEZIONE "CONOSCENZA ED USO DELLA LINGUA ITALIANA"

*bullizzato almeno una volta
quietly logit studiare bullying parlarebene, or r 
quietly logit studiare bullying parlarebene scriverebene, or r 
quietly logit studiare bullying parlarebene scriverebene pensa_ita,   or r 
estimates store mod4
* nel secondo modello bullying e  parlare bene italiano sembrerebbero essere non significative

*bullizzato spesso
quietly logit studiare bullying_often parlarebene, or r 
quietly logit studiare bullying_often parlarebene scriverebene, or r 
quietly logit studiare bullying_often parlarebene scriverebene pensa_ita, or r 
estimates store mod5
*situazione analoga ai 3 modelli precendenti, nel secondo la var bullying_often e parlare bene italiano non sono significative
*tuttavia qui la var bullying_often non lo è in nessun caso dal momento che si rilevano pvaluea piuttosto alti

*bullizzato sempre
quietly logit studiare bullying_everyday parlarebene, or r 
quietly logit studiare bullying_everyday parlarebene scriverebene, or r 
quietly logit studiare bullying_everyday parlarebene scriverebene pensa_ita, or r 
estimates store mod6


tab parlarebene lavorare, chi2

*rinomino le tre var esaminate
label var parlarebene "Parlare fluentemente italiano"
label var scriverebene "Scrivere italiano correttamente"
label var pensa_ita "Pensare in italiano"


*tutte significative, solo nel secondo modello parlarebene non lo è 

esttab mod4 mod5 mod6,b(%9.3f) se(%9.3f) eform pr2 label nogaps order() star(+ 0.10 * 0.05 ** 0.01 *** 0.001) title("Essere vittime di bullismo e iscriversi all'università. Modelli Logit con variabili relative alle competenze linguistiche. 1=Bullizzati almeno una volta; 2=Bullizzati spesso; 3=Bullizzati sempre")

*creo global "lingua_ita"
global lingua_ita "parlarebene scriverebene pensa_ita"


***MODELLI CON VAR RELATIVE ALLA SEZIONE "LA SCUOLA, GLI INSEGNANTI E I COMPAGNI"


*bullizzato almeno una volta
quietly logit studiare bullying rend_perc_male , or r 
quietly logit studiare bullying rend_perc_male mate_insuf , or r 
quietly logit studiare bullying rend_perc_male mate_insuf ita_male , or r 
quietly logit studiare bullying rend_perc_male mate_insuf ita_male bocciato, or r 
quietly logit studiare bullying rend_perc_male mate_insuf ita_male bocciato aiuto_compiti, or r 
quietly logit studiare bullying rend_perc_male mate_insuf ita_male bocciato aiuto_compiti esce_con_compagni , or r 
quietly logit studiare bullying rend_perc_male mate_insuf ita_male bocciato aiuto_compiti esce_con_compagni lavoretti_frequenti, or r 
quietly logit studiare bullying rend_perc_male mate_insuf ita_male bocciato aiuto_compiti esce_con_compagni lavoretti_frequenti crede_raccomandati, or r 
quietly logit studiare bullying rend_perc_male mate_insuf ita_male bocciato aiuto_compiti esce_con_compagni lavoretti_frequenti crede_raccomandati inizio_scuola_tardi, or r
estimates store mod7
*tutte significative tranne bullying

*bullizzato spesso
quietly logit studiare bullying_often rend_perc_male , or r 
quietly logit studiare bullying_often rend_perc_male mate_insuf , or r 
quietly logit studiare bullying_often rend_perc_male mate_insuf ita_male , or r 
quietly logit studiare bullying_often rend_perc_male mate_insuf ita_male bocciato, or r 
quietly logit studiare bullying_often rend_perc_male mate_insuf ita_male bocciato aiuto_compiti, or r 
quietly logit studiare bullying_often rend_perc_male mate_insuf ita_male bocciato aiuto_compiti esce_con_compagni , or r 
quietly logit studiare bullying_often rend_perc_male mate_insuf ita_male bocciato aiuto_compiti esce_con_compagni lavoretti_frequenti, or r 
quietly logit studiare bullying_often rend_perc_male mate_insuf ita_male bocciato aiuto_compiti esce_con_compagni lavoretti_frequenti crede_raccomandati, or r 
quietly logit studiare bullying_often rend_perc_male mate_insuf ita_male bocciato aiuto_compiti esce_con_compagni lavoretti_frequenti crede_raccomandati inizio_scuola_tardi, or r
estimates store mod8

*anche qua tutte significative tranne bullying

*bullizzato sempre
quietly logit studiare bullying_everyday rend_perc_male , or r 
quietly logit studiare bullying_everyday rend_perc_male mate_insuf , or r 
quietly logit studiare bullying_everyday rend_perc_male mate_insuf ita_male , or r 
quietly logit studiare bullying_everyday rend_perc_male mate_insuf ita_male bocciato, or r 
quietly logit studiare bullying_everyday rend_perc_male mate_insuf ita_male bocciato aiuto_compiti, or r 
quietly logit studiare bullying_everyday rend_perc_male mate_insuf ita_male bocciato aiuto_compiti esce_con_compagni , or r 
quietly logit studiare bullying_everyday rend_perc_male mate_insuf ita_male bocciato aiuto_compiti esce_con_compagni lavoretti_frequenti, or r 
quietly logit studiare bullying_everyday rend_perc_male mate_insuf ita_male bocciato aiuto_compiti esce_con_compagni lavoretti_frequenti crede_raccomandati, or r 
quietly logit studiare bullying_everyday rend_perc_male mate_insuf ita_male bocciato aiuto_compiti esce_con_compagni lavoretti_frequenti crede_raccomandati inizio_scuola_tardi, or r
estimates store mod9
*tutte significative
label var rend_perc_male "Rendimento percepito"
label var mate_insuf "Insufficiente in matematica"
label var ita_male "Insufficiente in italiano"
label var bocciato "Bocciato almeno una volta"
label var aiuto_compiti "Doposcuola"
label var esce_con_compagni "Frequenta i compagni di scuola nel tempo libero"
label var lavoretti_frequenti "Svolge spesso lavoretti"
label var crede_raccomandati "Crede che solo i raccomandati vadano avanti"
label var inizio_scuola_tardi "Ha iniziato la scuola in Italia dopo la quinta elementare"


esttab mod7 mod8 mod9,b(%9.3f) se(%9.3f) eform pr2 label nogaps order() star(+ 0.10 * 0.05 ** 0.01 *** 0.001) title("Essere vittime di bullismo e iscriversi all'università. Modelli Logit con variabili relative al contesto scolastico. 1=Bullizzati almeno una volta; 2=Bullizzati spesso; 3=Bullizzati sempre")

*creo global "scuola"

global scuola "rend_perc_male mate_insuf ita_male bocciato aiuto_compiti esce_con_compagni lavoretti_frequenti crede_raccomandati inizio_scuola_tardi"


**MODELLI CON VAR RELATIVE ALLA SEZIONE "IL TEMPO LIBERO E GLI AMICI"

*var indipendenti
tab amici_italiani esce_poco, chi2


*bullizzato almeno una volta
quietly logit studiare bullying uso_molto_internet , or r 
quietly logit studiare bullying uso_molto_internet sport , or r 
quietly logit studiare bullying uso_molto_internet sport amici_italiani , or r 
quietly logit studiare bullying uso_molto_internet sport amici_italiani esce_poco, or r 
estimates store mod10
*avere amici italiani sembrerebbe non essere significativo

*bullizzato spesso
quietly logit studiare bullying_often uso_molto_internet , or r 
quietly logit studiare bullying_often uso_molto_internet sport , or r 
quietly logit studiare bullying_often uso_molto_internet sport amici_italiani , or r 
quietly logit studiare bullying_often uso_molto_internet sport amici_italiani esce_poco, or r 
estimates store mod11
*bullying_often e amici italiani non sign

*bullizzato sempre
quietly logit studiare bullying_everyday uso_molto_internet , or r 
quietly logit studiare bullying_everyday uso_molto_internet sport , or r 
quietly logit studiare bullying_everyday uso_molto_internet sport amici_italiani , or r 
quietly logit studiare bullying_everyday uso_molto_internet sport amici_italiani esce_poco, or r 
estimates store mod12
*avere amici italiani è non significativo
label var uso_molto_internet "Naviga molto su internet"
label var sport "Pratica sport"
label var amici_italiani "Avere amici italiani"
label var esce_poco "Esce poco con gli amici"


esttab mod10 mod11 mod12,b(%9.3f) se(%9.3f) eform pr2 label nogaps order() star(+ 0.10 * 0.05 ** 0.01 *** 0.001) title("Essere vittime di bullismo e iscriversi all'università. Modelli Logit con variabili relative alla sfera sociale. 1=Bullizzati almeno una volta; 2=Bullizzati spesso; 3=Bullizzati sempre")

*bullying_everyday sign mentre amici_italiani ancora non sign

*creo global "tempo_libero"
global tempo_libero " uso_molto_internet sport esce_poco amici_italiani"

***MODELLI CON VAR RELATIVE ALLA SEZIONE "I TUOI GENITORI E LA TUA FAMIGLIA"

*var dipendenti, tengo solo vive con madre
tab vive_con_gen vive_solo_con_madre, chi2


*bullizzato almeno una volta 
quietly logit studiare bullying infl_gen_amicizie, or r 
quietly logit studiare bullying infl_gen_amicizie , or r 
quietly logit studiare bullying infl_gen_amicizie vive_solo_con_madre, or r 
quietly logit studiare bullying infl_gen_amicizie vive_solo_con_madre , or r 
quietly logit studiare bullying infl_gen_amicizie vive_solo_con_madre  frat_sor, or r 
quietly logit studiare bullying infl_gen_amicizie vive_solo_con_madre  frat_sor gen_lav, or r
quietly logit studiare bullying infl_gen_amicizie vive_solo_con_madre  frat_sor gen_lav istr_bassa_mad , or r
quietly logit studiare bullying infl_gen_amicizie vive_solo_con_madre  frat_sor gen_lav istr_bassa_mad istr_bassa_pad, or r
quietly logit studiare bullying infl_gen_amicizie vive_solo_con_madre  frat_sor gen_lav istr_bassa_mad istr_bassa_pad  confronto_con_famiglia, or r
estimates store mod13
*bullying e vivere solo con la madre non significative

*bullizzato spesso
quietly logit studiare bullying_often infl_gen_amicizie, or r 
quietly logit studiare bullying_often infl_gen_amicizie , or r 
quietly logit studiare bullying_often infl_gen_amicizie vive_solo_con_madre, or r 
quietly logit studiare bullying_often infl_gen_amicizie vive_solo_con_madre , or r 
quietly logit studiare bullying_often infl_gen_amicizie vive_solo_con_madre  frat_sor, or r 
quietly logit studiare bullying_often infl_gen_amicizie vive_solo_con_madre  frat_sor gen_lav, or r
quietly logit studiare bullying_often infl_gen_amicizie vive_solo_con_madre  frat_sor gen_lav istr_bassa_mad , or r
quietly logit studiare bullying_often infl_gen_amicizie vive_solo_con_madre  frat_sor gen_lav istr_bassa_mad istr_bassa_pad, or r
quietly logit studiare bullying_often infl_gen_amicizie vive_solo_con_madre  frat_sor gen_lav istr_bassa_mad istr_bassa_pad  confronto_con_famiglia, or r
estimates store mod14
*bullying_often e vivere solo con madre non significative

*bullizzato sempre 
quietly logit studiare bullying_everyday infl_gen_amicizie, or r 
quietly logit studiare bullying_everyday infl_gen_amicizie , or r 
quietly logit studiare bullying_everyday infl_gen_amicizie vive_solo_con_madre, or r 
quietly logit studiare bullying_everyday infl_gen_amicizie vive_solo_con_madre , or r 
quietly logit studiare bullying_everyday infl_gen_amicizie vive_solo_con_madre  frat_sor, or r 
quietly logit studiare bullying_everyday infl_gen_amicizie vive_solo_con_madre  frat_sor gen_lav, or r
quietly logit studiare bullying_everyday infl_gen_amicizie vive_solo_con_madre  frat_sor gen_lav istr_bassa_mad , or r
quietly logit studiare bullying_everyday infl_gen_amicizie vive_solo_con_madre  frat_sor gen_lav istr_bassa_mad istr_bassa_pad, or r
quietly logit studiare bullying_everyday infl_gen_amicizie vive_solo_con_madre  frat_sor gen_lav istr_bassa_mad istr_bassa_pad  confronto_con_famiglia, or r
estimates store mod15
*vivere solo con la madre è non significativa
label var infl_gen_amicizie "I genitori influenzano le sue amicizie"
label var vive_solo_con_madre "Vive solo con la madre"
label var frat_sor "Ha fratelli e/o sorelle"
label var gen_lav "Almeno un genitore lavora"
label var istr_bassa_mad "La madre ha un'istruzione bassa"
label var istr_bassa_pad "Il padre ha un'istruzione bassa"
label var confronto_con_famiglia "Si confronta spesso con la sua famiglia"

esttab mod13 mod14 mod15,b(%9.3f) se(%9.3f) eform pr2 label nogaps order() star(+ 0.10 * 0.05 ** 0.01 *** 0.001) title("Essere vittime di bullismo e iscriversi all'università. Modelli Logit con variabili relative alla sfera familiare. 1=Bullizzati almeno una volta; 2=Bullizzati spesso; 3=Bullizzati sempre")

*creo global "famiglia"
global famiglia " infl_gen_amicizie vive_solo_con_madre frat_sor gen_lav istr_bassa_mad istr_bassa_pad confronto_con_famiglia"


****MODELLI CON VAR RELATIVE ALLA SEZIONE "LA CASA E LA ZONA IN CUI VIVI"


*bullizzato almeno una volta
quietly logit studiare bullying scuola_lontana , or r 
quietly logit studiare bullying scuola_lontana cameretta, or r 
quietly logit studiare bullying scuola_lontana cameretta extr_pov, or r 
quietly logit studiare bullying scuola_lontana cameretta extr_pov pc rural, or r 
estimates store mod16
*avere una cameretta tutta per sè e bullying sembranno non essere significative

*tutte significative tranne bullying

*bullizzato spesso
quietly logit studiare bullying_often scuola_lontana , or r 
quietly logit studiare bullying_often scuola_lontana cameretta, or r 
quietly logit studiare bullying_often scuola_lontana cameretta extr_pov, or r 
quietly logit studiare bullying_often scuola_lontana cameretta extr_pov pc rural, or r 
estimates store mod17
*situazione analoga ai modelli precedenti

*bullizzato sempre
quietly logit studiare bullying_everyday scuola_lontana , or r 
quietly logit studiare bullying_everyday scuola_lontana cameretta, or r 
quietly logit studiare bullying_everyday scuola_lontana cameretta extr_pov, or r 
quietly logit studiare bullying_everyday scuola_lontana cameretta extr_pov pc, or r 
quietly logit studiare bullying_everyday scuola_lontana cameretta extr_pov pc rural, or r 
estimates store mod18
*tutte significative
label var scuola_lontana "viaggia per più di 30 min con un mezzo per raggiungere la scuola"
label var cameretta "ha una camera propria"
label var extr_pov "povertà estrema"
label var pc "La famiglia possiede un pc"
label var rural "Vive in periferia"


esttab mod16 mod17 mod18,b(%9.3f) se(%9.3f) eform pr2 label nogaps order() star(+ 0.10 * 0.05 ** 0.01 *** 0.001) title("Essere vittime di bullismo e iscriversi all'università. Modelli Logit con variabili relative alla casa e alla zona in cui vive. 1=Bullizzati almeno una volta; 2=Bullizzati spesso; 3=Bullizzati sempre")


*global "abitazione"
global abitazione "scuola_lontana cameretta extr_pov pc rural"


*ROBUSTNESS CHECKS

*usiamo una var discreta che trattiamo come continua
*ricodifichiamo le modalità
gen amo_fare_compiti=0 
replace amo_fare_compiti=1 if c14_b_2=="5"
replace amo_fare_compiti=2 if c14_b_2=="4"
replace amo_fare_compiti=3 if c14_b_2=="3"
replace amo_fare_compiti=4 if c14_b_2=="2"
replace amo_fare_compiti=5 if c14_b_2=="1"

quietly reg amo_fare_compiti bullying_everyday $vissuto, r
estimates store mod19
quietly reg amo_fare_compiti bullying_everyday $lingua_ita, r
estimates store mod20
quietly reg amo_fare_compiti bullying_everyday $scuola, r
estimates store mod21
quietly reg amo_fare_compiti bullying_everyday $tempo_libero, r
estimates store mod22
quietly reg amo_fare_compiti bullying_everyday $famiglia, r
estimates store mod23
quietly reg amo_fare_compiti bullying_everyday $abitazione, r
estimates store mod24
esttab mod19 mod20 mod21 mod22 mod23 mod24,b(%9.3f) se(%9.3f) r2 label nogaps order() star(+ 0.10 * 0.05 ** 0.01 *** 0.001) title("Passione verso lo studio. Modelli Lineari. 1=Vissuto; 2=Padronanza Italiano; 3=Scuola; 4=Tempo Libero; 5=Famiglia; 6=Abitazione e zona in cui vive")

*la variabile riferita al bullying è sempre e comunque significativa e negativamente associata al grado di apprezzamento dello studio, ci sono dei cambi di segno
log close
