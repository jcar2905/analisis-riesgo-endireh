# Análisis de Riesgo de Violencia de Pareja — ENDIREH 2021

## Descripción
Análisis estadístico que identifica factores de riesgo asociados a la violencia física 
de pareja en México, utilizando datos reales de la Encuesta Nacional sobre la Dinámica 
de las Relaciones en los Hogares (ENDIREH 2021).

## Pregunta de investigación
¿Qué factores del entorno familiar durante la infancia aumentan la probabilidad 
de que una mujer sufra violencia física por parte de su pareja?

## Metodología
- **Datos:** ENDIREH 2021 — 65,861 observaciones de mujeres casadas o unidas con pareja residente
- **Herramienta:** Stata
- **Modelo:** Regresión logística binaria con ponderación muestral (FAC_MUJ)
- **Métricas:** Efectos marginales promedio (AME) con IC 95%
- **Significancia:** Todos los resultados significativos al 1%

## Hallazgos principales

| Variable | Efecto Marginal | Interpretación |
|---|---|---|
| Insultos del esposo a hijos | +4.53 pp | Mayor predictor de riesgo |
| Golpes a la madre del esposo | +2.28 pp | Riesgo intergeneracional |
| Golpes del esposo a hijos | +2.22 pp | Patrón de violencia activa |
| Insultos al esposo de niño | +1.64 pp | Violencia aprendida |
| Golpes a la encuestada de niña | +1.09 pp | Revictimización |
| Años de escolaridad | −0.26 pp | Factor protector |

## Estructura del repositorio

- **code/** — Script de Stata con limpieza, modelado y visualización
- **results/** — Paper académico con metodología y resultados completos  
- **data/** — Instrucciones para descargar los datos de INEGI

## Datos
Los microdatos de la ENDIREH 2021 están disponibles gratuitamente en INEGI:

🔗 https://www.inegi.org.mx/programas/endireh/2021/

Archivos necesarios: `TB_SEC_IVaVD.dta` y `TSDem.dta`

Colócalos en la carpeta `/data/` para ejecutar el script correctamente.

## Tecnologías
![Stata](https://img.shields.io/badge/Stata-1A6696?style=flat&logo=stata&logoColor=white)

## Autor
**Juan Carlos Haro Ortega**  
Licenciado en Matemáticas Aplicadas — UAEH 2025  
carloshaor@outlook.com | [github.com/jcar2905](https://github.com/jcar2905)
