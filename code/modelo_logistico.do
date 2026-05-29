* Nota: Descarga los datos de la ENDIREH 2021 en:
* https://www.inegi.org.mx/programas/endireh/2021/
* Coloca TB_SEC_IVaVD.dta y TSDem.dta en la carpeta /data/

use "data/TB_SEC_IVaVD.dta", clear
joinby ID_PER using "data/TSDem.dta", _merge(_merge)
drop _merge

//T_INSTRUM:
//A1 Mujer casada o unida con pareja residente
//A2 Mujer casada o unida con pareja ausente temporal
//B1 Mujer separada o divorciada
//B2 Mujer viuda
//C1 Mujer soltera con novio o pareja o exnovio o expareja
//C2 Mujer soltera que nunca ha tenido novio

destring P13_1_3_7 P12_3 P12_4 P12_5 P12_6 P12_7 P12_8 P12_9 P12_10 P12_11 P12_12 P12_13 P2_13 COD_M15 EDAD NIV P4BC_2 P13_5 P13_1, replace

tab P13_5

tab P13_1

keep if T_INSTRUM == "A1" & EDAD<=97 & P13_5 == 1

//pareja hombre: P13_5
//Hombre: 1
//Mujer: 2
//No especificado: 9

//P13_1_3_7: Cuando su esposo o pareja se enoja con usted ... ¿la(o) golpea o agrede físicamente?
gen violencia_fisica_pareja_hoy = .
replace violencia_fisica_pareja_hoy = 1 if P13_1_3_7 == 1
replace violencia_fisica_pareja_hoy = 0 if P13_1_3_7 == 2


//En total, ¿cuántas hijas e hijos nacidos vivos ha tenido?
gen hijos =.
replace hijos = 1 if P13_1 != 0
replace hijos = 0 if P13_1 == 0

//P12_3: El lugar donde usted vivió la mayor parte del tiempo hasta antes de cumplir 15 años era…
rename P12_3 lugar_donde_vivio
tab(lugar_donde_vivio), gen(Ilugar_donde_vivio)

//Ilugar_donde_vivio1: ranchería, pueblo o comunidad pequeña
//Ilugar_donde_vivio2: un pueblo mediano
//Ilugar_donde_vivio3: una ciudad pequeña
//Ilugar_donde_vivio4: una ciudad grande

//P12_4: Recuerda si entre las personas adultas con las que vivía, había golpes…
//1 - de vez en cuando?
//2 - seguido?
//3 - No había golpes
gen golpes_adultos_hogar = .
replace golpes_adultos_hogar = 1 if P12_4 == 1 | P12_4 == 2
replace golpes_adultos_hogar = 0 if P12_4 == 3

//P12_5: ¿Recuerda si las personas con las que vivía se insultaban o se ofendían…
//1 - de vez en cuando?
//2 - seguido?
//3 - No había golpes
gen insultos_hogar = .
replace insultos_hogar = 1 if P12_5 == 1 | P12_5 == 2
replace insultos_hogar = 0 if P12_5 == 3

//P12_6: ¿Las personas con las que vivía le pegaban a usted…
//1 - de vez en cuando?
//2 - seguido
//3 - No le pegaba
gen golpes_a_encuestada = .
replace golpes_a_encuestada = 1 if P12_6 == 1 | P12_6 == 2
replace golpes_a_encuestada = 0 if P12_6 == 3 

//P12_7: ¿Recuerda si las personas con las que vivía la insultaban o la ofendían a usted…
//1 - de vez en cuando?
//2 - seguido?
//3 - No la insultaban ni la ofendían
gen insultos_a_encuestada = .
replace insultos_a_encuestada = 1 if P12_7 == 1 | P12_7 == 2
replace insultos_a_encuestada = 0 if P12_7 == 3 

//P12_8: Cuando su pareja o esposo era niño (hasta antes de cumplir 15 años), ¿le pegaban o insultaban en su casa…
//1 - de vez en cuando?
//2 - seguido?
//3 - No le pegaban ni lo insultaban
//8 - No sabe
gen insultos_esposo = .
replace insultos_esposo = 1 if P12_8 == 1 | P12_8 == 2
replace insultos_esposo = 0 if P12_8 == 3

//P12_9: ¿Sabe si cuando su pareja o esposo era niño (hasta antes de cumplir 15 años), a la mamá de él le pegaba su marido?
//3 - Sí le pegaba
//2 - No le pegaba
//8 - No sabe
gen golpes_mama_esposo = .
replace golpes_mama_esposo = 1 if P12_9 == 1
replace golpes_mama_esposo = 0 if P12_9 == 2

//P12_10: Cuando su esposo o pareja se enoja o enojaba consus hijas e hijos, ¿los insulta o insultaba…
//1 - de vez en cuando?
//2 - seguido?
//3 - No los insulta
//4 - No tiene hijos(as)
gen insultos_esposo_hijos = .
replace insultos_esposo_hijos = 1 if P12_10 == 1 | P12_10 == 2
replace insultos_esposo_hijos = 0 if P12_10 == 3

//P12_11: Cuando su esposo o pareja se enoja o enojaba con sus hijas e hijos, ¿les pega o pegaba…
//1 - de vez en cuando?
//2 - seguido?
//3 - No les pega
//4 - No tiene hijos(as)
gen golpes_esposo_hijos = .
replace golpes_esposo_hijos = 1 if P12_11 == 1 | P12_11 == 2
replace golpes_esposo_hijos = 0 if P12_11 == 3

//¿Trabajó la semana pasada?
//1 - Si
//2 - No
gen trabajo = .
replace trabajo = 1 if P2_13 == 1
replace trabajo = 0 if P2_13 == 2

gen anios_e = .
replace anios_e = 0 if NIV == 0     // Ninguno
replace anios_e = 3 if NIV == 1     // Preescolar
replace anios_e = 6 if NIV == 2     // Primaria
replace anios_e = 9 if NIV == 3     // Secundaria
replace anios_e = 12 if NIV == 4    // Preparatoria o bachillerato
replace anios_e = 9 if NIV == 5     // Técnicos/comerciales con primaria
replace anios_e = 12 if NIV == 6    // Técnicos/comerciales con secundaria
replace anios_e = 15 if NIV == 7    // Técnicos/comerciales con preparatoria
replace anios_e = 12 if NIV == 8    // Normal con primaria o secundaria
replace anios_e = 16 if NIV == 9    // Normal licenciatura
replace anios_e = 16 if NIV == 10   // Licenciatura o profesional
replace anios_e = 18 if NIV == 11   // Posgrado (Especialidad, Maestría o Doctorado)

// estadistica descriptiva
sum Ilugar_donde_vivio1 Ilugar_donde_vivio2 Ilugar_donde_vivio3 Ilugar_donde_vivio4 golpes_adultos_hogar insultos_hogar golpes_a_encuestada insultos_a_encuestada insultos_esposo golpes_mama_esposo insultos_esposo_hijos golpes_esposo_hijos EDAD anios_e trabajo if violencia_fisica_pareja_hoy == 0

sum Ilugar_donde_vivio1 Ilugar_donde_vivio2 Ilugar_donde_vivio3 Ilugar_donde_vivio4 golpes_adultos_hogar insultos_hogar golpes_a_encuestada insultos_a_encuestada insultos_esposo golpes_mama_esposo insultos_esposo_hijos golpes_esposo_hijos EDAD anios_e trabajo if violencia_fisica_pareja_hoy == 1

// Estimación del modelo logit
logit violencia_fisica_pareja_hoy Ilugar_donde_vivio1 Ilugar_donde_vivio2 Ilugar_donde_vivio3 golpes_adultos_hogar insultos_hogar golpes_a_encuestada insultos_a_encuestada insultos_esposo golpes_mama_esposo insultos_esposo_hijos golpes_esposo_hijos EDAD anios_e trabajo [fw = FAC_MUJ]

// Calcular efectos marginales promedio
margins, dydx(*) 

// Extraer los coeficientes y errores estándar de los efectos marginales
matrix b = r(b)
matrix V = r(V)

matrix list b
matrix list V

// Crear variables para coeficientes, errores estándar e intervalos de confianza
gen coeficientes = .
gen se = .
gen var_index = _n
gen var_index_dos = _n/10

// Iterar sobre las variables independientes para guardar los efectos marginales y sus intervalos de confianza
local i = 1
foreach x in Ilugar_donde_vivio1 Ilugar_donde_vivio2 Ilugar_donde_vivio3 golpes_adultos_hogar insultos_hogar golpes_a_encuestada insultos_a_encuestada insultos_esposo golpes_mama_esposo insultos_esposo_hijos golpes_esposo_hijos EDAD anios_e trabajo {
    replace coeficientes = _b[`x'] if var_index == `i'
    replace se = sqrt(V[`i', `i']) if var_index == `i'
    label var var_index "`x'" // Asignar la etiqueta de la variable
    local ++i
}

// Crear intervalos de confianza
gen li = coeficientes - se*invnormal(0.975)
gen ls = coeficientes + se*invnormal(0.975)
	   
	
// Graficar los efectos marginales con sus intervalos de confianza y mejoras estéticas

twoway (scatter coeficientes var_index if var_index >= 1 & var_index <= 3, msize(small) mcolor(blue) mlabel(coeficientes) mlabposition(4) msymbol(circle)) ///
       (rcap li ls var_index if var_index >= 1 & var_index <= 3, lwidth(medium) lcolor(blue)), ///
       xscale(range(0.5 3.5)) ///
       xlabel(1 "comunidad pequeña" 2 "pueblo mediano" 3 "ciudad pequeña", angle(45) labsize(vsmall) grid) ///
       yline(0, lstyle(dash) lwidth(thick) lcolor(gs12)) ///
       ytitle("Efectos marginales", size(medium)) xtitle("", size(medium)) ///
       legend(off) title("Efectos Marginales por Tipo de Comunidad (relativo a una ciudad grande)", size(medium)) ///
       plotregion(margin(5 5 5 5)) yscale(noline) ylabel(0, nogrid)

// Graficar los efectos marginales con sus intervalos de confianza y mejoras estéticas

twoway (scatter coeficientes var_index if var_index >= 4 & var_index <= 9, msize(small) mcolor(red) mlabel(coeficientes) mlabposition(4) msymbol(circle)) ///
       (rcap li ls var_index if var_index >= 4 & var_index <= 9, lwidth(medium) lcolor(red)), ///
       xscale(range(3.9 9.5)) ///
       xlabel(4 "Golpes en el hogar" 5 "Insultos en el hogar" 6 "Golpes a la encuestada cuando era niña" ///
              7 "Insultos a la encuestada cuando era niña" 8 "Insultos al esposo de la encuestada cuando era niño" ///
              9 "Golpes a la mamá del esposo cuando él era niño", angle(45) labsize(vsmall) grid) ///
       yline(0, lstyle(dash) lwidth(thick) lcolor(gs12)) ///
       ytitle("Efectos marginales", size(medium)) xtitle(" ", size(medium)) ///
       legend(off) title("Efectos Marginales por tipo de violencia en el hogar en la infancia", size(medium)) ///
       plotregion(margin(5 5 5 5)) yscale(noline) ylabel(0, nogrid)

// Graficar los efectos marginales con sus intervalos de confianza y mejoras estéticas

twoway (scatter coeficientes var_index if var_index >= 10 & var_index <= 14, msize(small) mcolor(green) mlabel(coeficientes) mlabposition(4) msymbol(circle)) ///
       (rcap li ls var_index if var_index >= 10 & var_index <= 14, lwidth(medium) lcolor(green)), ///
       xscale(range(9.9 14.5)) ///
       xlabel(10 "Golpes del esposo a los hijos" 11 "Insultos del esposo a los hijos" ///
              12 "Edad" 13 "Años de escolaridad de la encuestada" 14 "Trabajo", angle(45) labsize(vsmall) grid) ///
       yline(0, lstyle(dash) lwidth(thick) lcolor(gs12)) ///
       ytitle("Efectos marginales", size(medium)) xtitle(" ", size(medium)) ///
       legend(off) title("Efectos Marginales por características personales y familiares en el presente", size(medium)) ///
       plotregion(margin(5 5 5 5)) yscale(noline) ylabel(0, nogrid)

label define golpes_lbl 0 "No" 1 "Sí"
label values violencia_fisica_pareja_hoy golpes_lbl

graph bar , over(violencia_fisica_pareja_hoy, label(valuelabel) sort(1)) /// 
    title("Cuando su esposo o pareja se enoja con usted ... ¿la(o) golpea o agrede físicamente?", size(small)) ///
    ytitle("Frecuencia ponderada") ///
    bar(1, color(navy)) bar(2, color(red)) ///
    blabel(bar, format(%9.0fc)) ///
    legend(off) ///
    graphregion(color(white)) ///
    note("Fuente: ENDIREH, cálculo propio", size(small))

