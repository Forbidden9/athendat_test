# athendat_test
Prueba Técnica para Desarrollador Móvil Flutter

## Descripción de la Prueba Técnica
Deberás desarrollar una aplicación móvil en Flutter que funcione como una herramienta de gestión de aprobación de productos (To-Do) con las siguientes características:

Requerimientos funcionales:
1. Pantallas principales:  
*1.1* `Productos por revisar:` Muestra una lista inicial de 10 productos obtenidos de una API fake (recomendada: JSONPlaceholder o MockAPI).
Cada producto debe incluir un checkbox para aprobar o rechazar.

   *1.2* `Productos revisados:` Lista con scroll infinito y paginación (7 productos por página) que muestre los productos aprobados o rechazados.
   * Cada producto debe presentarse en una card con un diseño limpio.
   * Funcionalidades:
     * Eliminar producto de la lista.
     * Ver detalles del producto en un dialog/modal.

2. Almacenamiento local:
Implementa una base de datos local utilizando SQLite o IsarDB para guardar los datos de los productos y sus estados (aprobados/rechazados).

3. Consumo de la API:
La comunicación con la API debe implementarse utilizando el patrón adaptador.
