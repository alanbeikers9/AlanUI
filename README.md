# 🌟 AlanUI v2.13.3

**Roblox · PC & Mobile · MIT License**

<p align="center">
  <a href="README_en.md">🇬🇧 Read in English</a>
  &nbsp;·&nbsp;
  <a href="#-probar-la-vitrina-interactiva">🎮 Probar la vitrina</a>
  &nbsp;·&nbsp;
  <a href="#-solución-de-problemas-rápidos">🩹 Problemas frecuentes</a>
  &nbsp;·&nbsp;
  <a href="#-novedades-v2133">🆕 Novedades</a>
  &nbsp;·&nbsp;
  <a href="#-historial-de-versiones-anteriores">📜 Historial</a>
</p>

Librería de interfaz para scripts de Roblox, optimizada y pensada para funcionar bien tanto en PC como en móvil. Se construyó siguiendo un orden de prioridades claro:

**Compatibilidad > Rendimiento > Simplicidad > Diseño**

AlanUI está hecha para no generar lag ni siquiera en PCs de gama baja o en celulares, que es donde la mayoría de las librerías pesadas empiezan a fallar.

---

## ⚡ Características principales

* 🚀 **Sin lag y sin memory leaks:** al re-ejecutar tu script **o al cerrar la ventana**, AlanUI desconecta todo lo que creó (conexiones, hilos, dibujos, instancias y hasta los listeners globales de arrastre), sin dejar nada escuchando.
* 📱 **Diseño responsive real:** la interfaz se adapta sola entre pantalla de PC y de celular.
* 💾 **Guardado automático de configuración, en dos sistemas separados:** los ajustes de la propia interfaz (tema, tamaño) y los perfiles de tu script (sliders, toggles, dropdowns) se guardan por separado, sin mezclarse nunca.
* 🔍 **Dropdowns inteligentes:** si un menú desplegable tiene más de 8 opciones, se le agrega automáticamente una barra de búsqueda.
* 🎨 **Sistema de temas nativo:** cambia entre Negro, Blanco, Verde, Morado, Rojo y Neon sin configuración extra.
* 🔧 **Pestaña de sistema incluida automáticamente y modular:** cada ventana nace con una pestaña "Preinstalada" hecha de cinco módulos (Sistema, Apariencia, Configuración, Perfiles e Historial), sin que el desarrollador tenga que llamar nada. Se puede quitar entera, elegir qué módulos lleva o colocar un módulo suelto en cualquier pestaña.
* 🧩 **18 tipos de control:** desde `Toggle`/`Slider`/`Dropdown` hasta `RangeSlider`, `NumberStepper`, `TagInput`, `Imagen` y `Grupo` de botones, más `Seccion:Construir` para armar una sección entera desde una tabla.
* ↩️ **Deshacer / Rehacer global:** todos los cambios de controles se registran solos en un historial (50 pasos), sin que el desarrollador configure nada.
* 🔒 **Bloqueo y resaltado de controles:** cualquier control interactivo se puede bloquear con un motivo visible (`Lock`) o resaltar con un pulso (`Highlight`).
* 📱 **Modo Mini (v2.12.6):** una interfaz compacta tipo panel plegable para scripts simples, con alto automático, que se pliega con un toque al título. Una ventana puede cambiar entre Mini y completo en vivo con `Ventana:CambiarModo`.
* 🩺 **Herramientas de diagnóstico y validación (v2.12.6):** `Profiler(true)` compara contadores entre lecturas, `DiagnosticoCompleto(true)` arma un reporte para soporte, y la librería avisa sola de Flags repetidas y, con `Opciones.ModoDev`, de claves mal escritas.
* 🎨 **Estilo visual moderno (opcional, v2.12.6):** `EstiloVisual = "moderno"` afina el aspecto sin cambiar el comportamiento: ayuda discreta, "✕" gris que se pone roja al pasar el cursor, pestaña activa más marcada, buscador con lupa vectorial y estados con un punto de color en lugar de emojis.

---

## 📸 Capturas / Vista previa

> ✨ *Aquí puedes poner un GIF o captura de tu interfaz — ayuda mucho a que la gente se anime a probarla.*

---

## 🚀 Instalación y primer uso

Carga la librería con `loadstring`. **Versión corta**, todo lo demás tiene valores por defecto:

```lua
local AlanUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/alanbeikers9/AlanUI/refs/heads/main/AlanUI.lua"))()

local Ventana = AlanUI:CrearVentana("Mi script")
local Seccion = Ventana:CrearTab("Principal", "🏠"):CrearSeccion("Combate")

Seccion:Toggle("Modo Automático", false, function(estado) print(estado) end)
Seccion:Slider("Velocidad", 0, 100, 50)
AlanUI:Notificar("¡Cargado!", "El script se ejecutó")
```

> La forma corta usa el autoguardado con el `NombreConfig` de siempre (`"autosave"`). Si publicas varios scripts, pasa `ScriptId = "mi-script"` o un `NombreConfig` propio para que no compartan perfil.

**Versión completa**, con todas las opciones a la vista:

```lua
local AlanUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/alanbeikers9/AlanUI/refs/heads/main/AlanUI.lua"))()

-- ── CREAR LA VENTANA PRINCIPAL ──
local Ventana = AlanUI:CrearVentana({
    Titulo        = "AlanUI Premium",
    Subtitulo     = "by AlanbeikersFF",
    TamanoX       = 560,
    TamanoY       = 340,
    TeclaToggle   = Enum.KeyCode.RightControl, -- tecla para abrir/cerrar la interfaz
    Buscador      = true,                      -- activa la barra de búsqueda global
    AutoGuardar   = true,                      -- activa el guardado nativo de configuración
    NombreConfig  = "AlanUI_Settings",         -- nombre del archivo de configuración
})

-- ── CREAR TABS DE NAVEGACIÓN ──
local TabPrincipal = Ventana:CrearTab("Principal", "🏠")
local TabAjustes   = Ventana:CrearTab("Ajustes", "⚙️")

-- ── CREAR SECCIONES ──
local SeccionCombate = TabPrincipal:CrearSeccion("Combate / Automatización")
local SeccionTemas   = TabAjustes:CrearSeccion("Personalización de Interfaz")

-- ── AGREGAR TU PRIMER ELEMENTO ──
SeccionCombate:Toggle({
    Texto = "Modo Automático",
    Flag = "modoAutomatico",
    Defecto = false,
    Callback = function(estado)
        print("Modo Automático:", estado)
    end
})

-- ── ACTIVAR EL SELECTOR DE TEMAS NATIVO ──
Ventana:AgregarSelectorTemas()

-- ── AVISAR AL USUARIO QUE EL SCRIPT CARGÓ ──
AlanUI:Notificar({
    Titulo = "¡AlanUI Cargado!",
    Texto = "El script se ha ejecutado de forma exitosa.",
    Duracion = 5
})
```

### ⚙️ Parámetros de `CrearVentana`

Todos son opcionales: si no pasas nada, la ventana se crea con estos valores.

| Parámetro | Tipo | Por defecto | Qué hace |
|---|---|---|---|
| `Titulo` | texto | `"AlanUI"` | Título de la ventana. |
| `Subtitulo` | texto | `"by AlanbeikersFF"` | Texto bajo el título. La librería le agrega al final `•  AlanUI v<versión>` automáticamente. |
| `TamanoX` / `TamanoY` | número (px) | `560` / `340` | Tamaño base de la ventana. |
| `Mini` | booleano | `false` | Crea la ventana en [modo Mini](#-modo-mini): compacta, sin barra de pestañas ni buscador. |
| `TamanoMiniX` / `TamanoMiniY` | número (px) o `"auto"` | `260` / automático | Tamaño en modo Mini. Con alto automático la ventana se ajusta a su contenido (mínimo 94 px). |
| `AlturaMaximaMini` | número (px) | `440` | Tope del alto automático en Mini (nunca más del 90 % de la pantalla). |
| `EscalaMini` | número | automática | Escala en Mini, de 0.4 a 1.5. Sin ella: 0.6 en pantallas chicas y 0.85 en las demás. |
| `Plegado` | booleano | recordado | `true` hace nacer la ventana Mini plegada (solo el encabezado). Sin valor, se recuerda el último estado. |
| `BordesArrastrables` | booleano | activo en Mini y en ventanas alternables | Tiras de 8 px en los bordes para arrastrar la ventana. `true` las activa también en modo completo; `false` las quita. |
| `AutoCargar` | booleano | `true` en Mini, `false` en completo | Carga la configuración guardada al abrir la ventana. |
| `PermiteAlternarModo` | booleano | `true` en Mini, `false` en completo | Permite pasar entre Mini y completo con `Ventana:CambiarModo` y los botones ⤢ / ⤡. |
| `TamanoXCompleto` / `TamanoYCompleto` | número (px) | `560` / `340` | Tamaño al que crece una ventana que nació en Mini cuando pasa a modo completo. |
| `EstiloVisual` | `"clasico"` o `"moderno"` | `AlanUI.Opciones.EstiloVisual` (`"clasico"`) | Aspecto visual de esta ventana. Ver [Estilo visual moderno](#-estilo-visual-moderno-opcional). |
| `TeclaToggle` | `Enum.KeyCode` | `Enum.KeyCode.RightControl` | Tecla que abre y cierra la interfaz. |
| `Atajos` | `table`/`false` | las de `Opciones.Atajos` | Combinaciones de teclas de esta ventana (ver «Opciones»). |
| `AlReejecutar` | `function` | — | Se llama con la ventana al pulsar `RightShift+L`. Por ejemplo, destruir la ventana y volver a cargar el script. |
| `Transparencia` | `number` | `0` | De 0 a 0,6: transparencia del fondo, la barra de título y la barra lateral. Con `Opciones.TransparenciaEnControles = true` también las filas y las barras de los sliders. |
| `Borde` | formato de borde | el de siempre | Borde de la ventana con color, degradado y animación. Ver [Bordes con degradado y animación](#-bordes-con-degradado-y-animación-v2125). |
| `PosicionInicial` | `UDim2` | centro de la pantalla | Dónde nace la ventana. Es también la posición a la que vuelve `Ventana:ResetearPosicion`. |
| `GuardarPosicion` | booleano | `true` | Recuerda dónde dejaste la ventana entre ejecuciones. Con `false` siempre abre en `PosicionInicial`. Ver [Posición de la ventana](#posición-de-la-ventana-v2125). |
| `Orientacion` | texto | barra lateral | Con `"horizontal"` las pestañas van en una barra superior. Cualquier otro valor deja la barra lateral. Se puede cambiar después con `Ventana:CambiarOrientacion`. |
| `Buscador` | booleano | `true` | Barra de búsqueda global. Con `false` no se crea. |
| `PestanaPreinstalada` | `false` o tabla | activa en modo completo | `false` quita la pestaña del sistema; una tabla la personaliza: `{ Nombre = "⚙️ Sistema" }` cambia el nombre y `{ Modulos = { "Sistema", "Perfiles" } }` elige qué módulos lleva. En modo Mini no se agrega (ver [Preinstalada por módulos](#-preinstalada-por-módulos)). |
| `AutoGuardar` | booleano | `true` | Guarda los Flags solo, en segundo plano. Con `false` se desactiva. Necesita que el ejecutor soporte archivos. |
| `NombreConfig` | texto | `"autosave"` | Nombre del archivo de guardado: se escribe en `AlanUI/Config/<NombreConfig>.json`. |
| `Watermark` | texto | — | Etiqueta arrastrable en la pantalla (por ejemplo `"Mi script • v1.0"`) con los colores del tema. Sin ella no se crea nada. |

> ⚠️ **Pon siempre tu propio `NombreConfig`.** Si dos scripts que usan AlanUI no lo definen, los dos guardan en `AlanUI/Config/autosave.json` y se pisan los valores entre sí.

> ℹ️ **Nota importante:** en modo completo, al llamar `CrearVentana` la interfaz **ya viene con la pestaña "🔧 Preinstalada" agregada automáticamente** (rendimiento, info del ejecutor, selector de tema, orientación, tamaño de ventana, perfiles). No necesitas crearla ni llamarla — ya está ahí cuando la ventana termina de abrirse. En modo Mini no se agrega. Solo si por alguna razón NO la quieres, debes desactivarla explícitamente (ver sección de abajo).

---

## 🎮 Probar la vitrina interactiva

¿Prefieres ver todo funcionando antes de leer la referencia? Ejecuta la **vitrina**: una ventana de AlanUI con **6 pestañas** (Controles, Ventana y layout, Alertas, Estados, APIs y diagnóstico, y **Fugas y Mini**) donde cada control y cada función aparece en vivo, con un tooltip que explica qué demuestra.

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/alanbeikers9/AlanUI/refs/heads/main/AlanUI_Vitrina.lua"))()
```

Para probar cambios locales sin subirlos, poné `getgenv().ALANUI_LOCAL = true` antes de ejecutar la vitrina y dejá `AlanUI.lua` en la carpeta de tu ejecutor: en ese caso carga con `loadstring(readfile("AlanUI.lua"))` y el reporte lo marca como modo desarrollo.


- No necesitas cargar AlanUI antes: la vitrina la carga sola.
- El código está en [`AlanUI_Vitrina.lua`](AlanUI_Vitrina.lua), así que también sirve como **ejemplo completo y comentado** para copiar.
- En la pestaña **Alertas** hay una sección **Configurar tag** para armar un tag a tu gusto (texto, ícono, color, degradado, animación, clickeable) y agregarlo al header.
- Hay demos de los controles nuevos: `Keybind` en modo Hold y Toggle y un `ColorPicker` 2D (pestaña Controles), `Columnas` y la posición de la ventana (pestaña Ventana), `Dialogo` por tipo (pestaña Alertas) y las opciones globales (pestaña APIs).
- "Simular segundo script" abre la ventana nueva con el **mismo tamaño** que la primera, para que se vea igual que la primera vez que se lanzó la interfaz.
- La pestaña **Fugas y Mini** (v2.12.6) prueba lo nuevo y trae botones para abrir una **muestra del estilo visual** clásico y otra del moderno. Prueba: `Profiler(true)` y `DiagnosticoCompleto(true)`, el aviso de Flag repetida y `ModoDev` (se autoverifican capturando el `warn`), el **test de fugas** (crea y destruye 5 ventanas con 50 controles y comprueba que al cerrar no quede nada, incluida la doble destrucción), el `Sufijo` dinámico, `Placeholder`, `ObtenerOpciones`, el tope de la cola de notificaciones `SoloAlSoltar` (con contadores), el `Callback` por opción, el `Id` de notificaciones, `BloqueadoSi` (autoverificado), el tema `Neon` y las ventanas de prueba del modo Mini, con autotests de `Plegar`, `CambiarEscalaMini`, `AgregarModuloPreinstalado` y `CambiarModo`.

---

## 🧩 Compatibilidad con ejecutores (aproximada)

> ⚠️ **Es aproximada.** Solo probé AlanUI de verdad en lo de la tabla «Probado». Para los demás ejecutores no hay prueba: lo que sigue se deduce de las funciones que cada uno suele exponer, que cambian con las versiones. Corre la vitrina en el tuyo: el reporte te dice exactamente qué pasa y qué funciones tiene.

### ✅ Probado con la vitrina completa

| Ejecutor | Plataforma | Resultado |
|---|---|---|
| **Delta** | Android | 57 de 58 pruebas en la v2.13.2 (el único fallo era una prueba demasiado estricta, ya corregida) |
| **Arceus X** | Android | 53 de 54 pruebas en la v2.12.9 (el único fallo era una prueba mal escrita, ya corregida) |
| Roblox Studio (no es un ejecutor) | PC | Abre y funciona. Sin guardado en archivos, `Drawing`, `gethui` ni portapapeles, como es esperable |

### 🔎 Qué necesita para funcionar

* **Imprescindible:** `loadstring` y una forma de descargar el código (`game:HttpGet`, o `request`/`http_request`). Sin eso no se puede cargar la librería.
* **Recomendado:** `writefile` y `readfile` (guardado de configuración y perfiles), `gethui` o `protect_gui` (oculta la GUI de los scripts del juego).
* **Opcional:** `isfile`, `isfolder`, `makefolder`, `delfile` y `listfiles` (crear la carpeta, listar y borrar perfiles), `setclipboard` o sus alias (copiar diagnósticos y exportaciones) y `Drawing` (los elementos que dibujan sobre la pantalla).

Lo que falta lo detecta sola y se desactiva sin romper el resto: la interfaz sigue funcionando y el diagnóstico (`AlanUI:VerificarSoporte`, `DiagnosticoCompleto`) te dice qué se perdió.

### 🟡 Con matices

* **Sin `writefile`/`readfile`:** todo funciona, pero no se guarda nada entre ejecuciones.
* **Sin `listfiles`/`delfile` (o sin `isfolder`/`makefolder`):** el guardado funciona, pero no se pueden listar ni borrar perfiles ni crear la carpeta.
* **Sin `gethui` ni `protect_gui`:** la GUI queda en un contenedor que los scripts del juego pueden ver, así que un anticheat puede detectarla.
* **Sin `setclipboard`:** no se copian diagnósticos ni exportaciones.
* **Sin `Drawing`:** funciona, salvo lo que dibuja sobre la pantalla.
* **Sin `game:HttpGet` pero con `request`:** carga igual, con `loadstring(request(...).Body)`.

### ❌ No va a funcionar

* Ejecutores que **no exponen `loadstring`**, o que no tienen ninguna forma de descargar el código ni de leerlo de un archivo.
* Cualquier cliente sin ejecutor, como una consola (Xbox, PlayStation) o un cliente oficial sin modificar.

### ❔ Sin probar

Wave, Hydrogen, Fluxus, Codex, Xeno, Solara, Velocity y otros del mercado **no están probados**. Si exponen lo de «Qué necesita para funcionar» deberían funcionar, pero no lo afirmo. Si lo probás en alguno, contá qué funcionó y qué no con el reporte de la vitrina.


## 🩹 Solución de problemas rápidos

Los casos que más se repiten, con la causa y el arreglo. Cada uno enlaza a la sección donde está explicado a fondo.

- **Cambié `AlanUI.Flags.x = valor` y el control no se movió (o su `Callback` no corrió).** `AlanUI.Flags` solo guarda el dato. Para mover el control y disparar su `Callback`: `AlanUI:ObtenerElemento("x").Set(valor, true)`. Ver [El proxy de `AlanUI.Flags`](#-el-proxy-de-alanuiflags-escribir-vs-elementosflagset).
- **Dos scripts se pisan los ajustes guardados.** Los dos guardan en `AlanUI/Config/autosave.json` si no definen `NombreConfig`. Pon siempre uno propio en `CrearVentana` (tabla de *Parámetros de `CrearVentana`*).
- **Dos controles usan la misma `Flag`.** La consola avisa y el primero deja de ser accesible con `ObtenerElemento`. Pasa también cuando no pones `Flag` y dos controles tienen el mismo `Texto` (la `Flag` se deriva del `Texto`). Usa una `Flag` distinta en cada control.
- **Escribes mal una clave de un control (por ejemplo `Defaut`) y no pasa nada.** Las claves desconocidas se ignoran en silencio. Con `AlanUI.Opciones.ModoDev = true` la consola avisa y sugiere la correcta.
- **`Set` en un `Dropdown` `Multi` no selecciona nada.** Espera una tabla `{ Opcion = true }`, no una lista. Ver el aviso en [Dropdown](#3-dropdown-menú-desplegable) (`Set` en modo `Multi`).
- **Mi `Callback` se ejecuta cientos de veces mientras arrastro un slider.** Usa `SoloAlSoltar = true`: se llama una sola vez, al soltar. Ver [Parámetros nuevos en controles](#-parámetros-nuevos-en-controles-y-notificaciones).
- **En modo Mini no veo la Preinstalada, solo veo una pestaña, o el tamaño no es el que puse.** Mini no agrega la Preinstalada (usa `AgregarModuloPreinstalado`), solo es accesible la primera pestaña, y en una ventana que nace Mini `TamanoX` / `TamanoY` se leen como tamaño Mini. Ver [Modo Mini](#-modo-mini).
- **Quiero saber si mi script deja conexiones vivas después de cerrar.** Llama a `AlanUI:Profiler(true)` una vez para fijar la base y otra vez después de usar el script: si algo crece, mira el campo `Comparacion`. Cerrar la ventana limpia todo lo registrado; lo que crees sin `RegistrarConexion` y compañía es tuyo. Ver [Profiler bajo demanda](#-profiler-bajo-demanda-alanuiprofiler) y [Cierre limpio](#-cierre-limpio).
- **Mi ejecutor no soporta archivos.** La interfaz funciona, pero no se guardan ajustes ni posición. `AlanUI:VerificarSoporte("Archivos")` lo comprueba.
- **Voy a reportar un bug.** Incluye `AlanUI.Version` y `AlanUI.Build`, tu ejecutor, si la ventana era Mini o completa, los pasos para reproducirlo, y pega el resultado de [`AlanUI:DiagnosticoCompleto(true)`](#-alanuidiagnosticocompleto) (ya trae versión, entorno, opciones, Profiler y los últimos errores) junto con `AlanUI:ObtenerErrores()`.

## 🆕 Novedades v2.13.3

Revisión final antes de publicar: un fallo de la vitrina, la carga publicada y documentación.

### 🛠️ Correcciones

* **Vitrina, prueba «Animaciones».** Exigía cero tamaños intermedios en el modo `"ninguna"`, pero el cambio de modo se aplica en dos pasos instantáneos seguidos y a veces se muestrea uno entre ambos. Ahora una animación real es la que recorre 4 o más tamaños, y un cambio instantáneo, 2 o menos.

### 🆕 Novedades

* **La vitrina carga la librería como se publica:** `loadstring(game:HttpGet(url))`, o `loadstring` con `request` si el ejecutor no tiene `game:HttpGet`. Con `getgenv().ALANUI_LOCAL = true` usa `readfile("AlanUI.lua")` para probar cambios sin subirlos (modo desarrollo). La prueba «Carga de la librería» y el reporte indican qué método se usó, y la prueba falla si no es el publicado y no está activado el modo desarrollo.
* **`AlanUI.Animaciones` documentada y probada.** `Fade`, `Slide`, `Scale` y `Bounce` ya existían pero no estaban documentadas ni tenían prueba. Pasan por el mismo motor de animación, así que respetan `Opciones.Animaciones`.
* **Compatibilidad con ejecutores (aproximada)** documentada en una sección nueva.
* La prueba «Capacidades» comprueba además `EsStudio`, `TieneTouch`, `TieneMouse`, `Tipo`, `EsTactil`, `EsEscritorio` y `EsTouchOnly`.


## 🆕 Novedades v2.13.2

Amplía las capacidades que AlanUI detecta solo, sin funciones públicas nuevas: todo se agrega a `Capacidades`, a las Features y al diagnóstico que ya existían.

### 🆕 Novedades

* **`Capacidades.ProtectGUI` reconoce el contenedor oculto de `gethui`** (y sus alias `get_hidden_gui` y `gethiddengui`), que es el método vigente en los ejecutores actuales. Antes solo detectaba `syn.protect_gui` y `protectgui`, así que la pestaña Preinstalada avisaba «la GUI puede ser detectada por anti-cheats» aunque la GUI ya estuviera en el contenedor oculto. `GetHUI` reconoce los mismos alias, y la librería los usa al elegir dónde poner la GUI.
* **`Capacidades.ArchivosCompletos`** (nueva): `true` si el ejecutor expone `isfile`, `isfolder`, `makefolder`, `delfile` y `listfiles` además de `writefile` y `readfile`. Aparece como feature opcional `ArchivosCompletos` en el diagnóstico. El `SaveManager` ya protegía cada una de esas funciones por separado: esto solo lo hace visible.
* **`Capacidades.Portapapeles`** (nueva): `true` si hay `setclipboard` o alguno de sus alias (`toclipboard`, `set_clipboard`). La feature `SetClipboard` la usa, y `DiagnosticoCompleto(true)` y la exportación de perfiles copian con el alias que exista.
* **`Capacidades.NavegacionGamepad`** (nueva): `true` si el motor tiene activada la navegación de la GUI con el D-pad o el stick (`GuiService.GuiNavigationEnabled`). Es informativa: los botones de AlanUI son `TextButton`, que el motor ya vuelve seleccionables.
* **Memoria de Lua e instancias de UI en el diagnóstico.** `Profiler()` y `DiagnosticoCompleto` suman `MemoriaLuaMb` (el heap de Lua, aparte de la memoria total del cliente) e `InstanciasUI` (las instancias de UI vivas que la librería ya contaba). La pestaña Sistema muestra la memoria de Lua junto a la total.

Las features pasan a ser 10.

### 🧪 Vitrina

* Prueba nueva «Capacidades: protección de la GUI, archivos completos, portapapeles y navegación». Las de «Profiler» y «DiagnosticoCompleto» comprueban los campos nuevos.


## 🆕 Novedades v2.13.1

Corrige los dos fallos del reporte de la 2.13.0 (Delta, Android): uno era un defecto de la librería y el otro, de una prueba.

### 🛠️ Correcciones

* **Cambio de modo (completo ↔ mini) con `Animaciones = "fantasma"`.** La regla de contenedores pesados convertía en instantáneo el cambio de tamaño de la ventana, que se hace con el contenido oculto y es barato de animar. Ahora se anima en `"fantasma"` y `"tamano"`, y sigue siendo instantáneo en `"ninguna"`. Cambiar el alto o el ancho de la ventana con el contenido a la vista sigue siendo instantáneo en `"fantasma"`.

### 🧪 Vitrina

* «Animaciones» medía el tamaño de la ventana en el momento equivocado (el cambio de modo espera a que termine el fundido de su cubierta). Ahora lo muestrea fotograma a fotograma y cuenta los tamaños intermedios al cambiar el alto y al cambiar de modo.
* «Indicador de guardado» esperaba el puntito en gris al abrir la ventana, pero crear los controles escribe sus Flags, así que arranca en ámbar hasta el primer autoguardado. Ahora comprueba el ciclo ámbar → verde → gris.


## 🆕 Novedades v2.13.0

Sale del reporte de la 2.12.9 (la pestaña Preinstalada y una ventana de 125 controles en un Samsung S23) y de diez propuestas de otras IAs, de las que entraron tres. Todo es aditivo y las opciones nuevas conservan el comportamiento anterior salvo `Animaciones`, que se pidió expresamente.

### 🆕 Novedades

* **Un solo selector de animaciones para toda la interfaz: `AlanUI.Opciones.Animaciones`** (`"fantasma"` por defecto). `"fantasma"`: la ventana se minimiza y se muestra animando un marco liviano y los cambios de **tamaño** de contenedores pesados (más de 80 descendientes y con su contenido a la vista: la ventana al cambiar su alto o su ancho, secciones grandes) se aplican al instante; todo lo demás (colores, deslizamientos, notificaciones, controles chicos) se anima igual que siempre. `"tamano"`: se anima todo, incluido el tamaño de la ventana real (la interfaz de la 2.12.7). `"ninguna"`: nada se anima, tampoco los bordes y degradados que giran; todo cambia al instante, lo más barato para dispositivos viejos. El motivo: animar el tamaño de un contenedor con muchos controles obliga al motor a recalcular el layout de todos en cada fotograma.
* **`AnimacionVentana` pasa a `"auto"` por defecto:** sigue a `Animaciones`. Con `"fantasma"`, `"tamano"` o `"ninguna"` fuerza ese modo solo para minimizar y mostrar.
* **Tema a partir de un color.** `ThemeManager:AplicarTema(Color3.fromRGB(200, 60, 90))` arma un tema oscuro completo con ese color como acento (los fondos toman su tono con poca saturación y el texto sale de la luminancia), y `AplicarTema({ Base = Color3, Claro = true })` uno claro. Usa el mismo motor de aplicación de temas; los cuatro colores de estado se completan solos.
* **`AlanUI.Opciones.AutoContraste`** (`false` por defecto). Con `true`, al aplicar un tema, el texto (`Text` y `TextDark`) que no llegue a un contraste de 4.5:1 (WCAG AA) con los fondos (`Panel`, `Fila` y `Background`) pasa a blanco o negro, el que más contraste dé.
* **`AlanUI.Opciones.IndicadorGuardado`** (`false` por defecto). Con `true`, un puntito en la esquina de la barra de título muestra el estado del autoguardado: gris sin cambios, ámbar con cambios pendientes y verde unos segundos tras guardar. Solo aparece si `AutoGuardar` está activo. Al abrir la ventana arranca en ámbar hasta el primer guardado, porque crear los controles escribe sus Flags.

Las opciones pasan a ser 22.

### 🧪 Vitrina

* Pruebas nuevas: «Animaciones: fantasma, tamano y ninguna», «Temas: derivado de un color y AutoContraste» e «Indicador de guardado». Los selectores de las cuatro opciones están en la sección Opciones.
* «Registro» comparaba el color de un tween con `==`; ahora usa una tolerancia (un tween de `Color3` puede terminar a una millonésima del destino) y muestra el color obtenido.
* La prueba de rendimiento mide ahora los tres modos de `Animaciones`.


## 🆕 Novedades v2.12.9

La 2.12.8 animaba el `UIScale` de la ventana al minimizar y volver a mostrar, con la idea de que el `UIScale` no obliga a recalcular el layout. Era falso: Roblox confirma que animar un `UIScale` también provoca relayouts, y en un Samsung S23 los FPS caían de 60 a unos 43 en la pestaña Preinstalada al minimizar y maximizar. Esta versión cambia la animación de raíz y corrige tres pruebas de la vitrina que estaban mal escritas.

### 🛠️ Correcciones

* **Minimizar y mostrar ya no animan la ventana real.** Ni su `Size` (2.12.7) ni su `UIScale` (2.12.8): ambos obligan al motor a recalcular el layout de todos los controles en cada fotograma. Ahora se anima un marco liviano (fondo y borde, sin hijos) y la ventana real aparece o desaparece de golpe, una sola vez.
* **Opción nueva `AlanUI.Opciones.AnimacionVentana`** (`"fantasma"` por defecto). `"tamano"` anima el tamaño de la ventana real (el comportamiento de la 2.12.7) y `"ninguna"` no anima. En un dispositivo muy limitado, `"ninguna"` es lo más barato. Las opciones pasan a ser 19.

### 🧪 Vitrina

* **Tres pruebas corregidas** (los fallos eran de las pruebas, no de la librería). «Formato escrito, Divider, Paleta y Columnas» comparaba `Color3` como clave de tabla (en Luau dos `Color3` iguales son claves distintas). «Registro» no esperaba a que terminara la restauración del tema guardado de la ventana nueva y registraba una instancia sin padre (`RegistrarInstancia` solo destruye instancias con padre, por diseño). «Dialogo MostrarCancelar» no creaba una ventana, y `Confirmar` necesita una activa.
* **Minimizar y Mostrar** se prueba ahora en los tres modos, y hay una prueba informativa, «Rendimiento: FPS al minimizar y mostrar», que mide los FPS promedio y los del peor fotograma en cada modo con una ventana pesada, para comparar en tu dispositivo. El selector de **Animación de la ventana** está en la sección Opciones.


## 🆕 Novedades v2.12.8

Esta versión sale de probar la vitrina en Roblox Studio y en un ejecutor móvil (Arceus X). Corrige cuatro errores que encontró la prueba de valores extremos, evita el tirón al volver a mostrar una ventana minimizada, hace que los iconos estén listos antes de verlos y suma una forma opcional de extender la transparencia a los controles. La vitrina se revisó entera: ahora cada método, opción, evento y clave de la interfaz tiene una prueba, y se quitaron las demostraciones repetidas.

### 🛠️ Correcciones

* **Cuatro errores con valores extremos.** `ThemeManager:AplicarTema("NoExiste")` fallaba con «invalid argument #1 to 'pairs'»: ahora un tema desconocido, o un valor que no es nombre ni tabla, no hace nada (y avisa en ModoDev). `Ventana:CambiarTema(nil)` fallaba al armar su notificación y, con un nombre inexistente, decía «aplicado»: ahora no hace nada si el tema no existe. `AlanUI:Notificar(5)` fallaba («attempt to index number with 'Id'»): un número se muestra como título. `Notificar({ Titulo = 123, Texto = {} })` intentaba poner una tabla en una propiedad de texto: ahora un número o un booleano se muestran como texto y cualquier otro valor se ignora. Además `Notificar` trabaja sobre una copia y ya no modifica la tabla que le pasás.
* **Tirón al minimizar y volver a expandir.** La ventana reaparecía animando su `Size`, y eso obliga al motor a recalcular el layout y el ajuste de texto de todos los controles en cada fotograma (y a partir de un ancho 0, el texto se parte en una letra por línea). Ahora minimizar y mostrar animan el `UIScale` de la ventana (de casi 0 a su escala), que se aplica después del layout y no lo repite. El tamaño de la ventana ya no pasa por 0 mientras está minimizada. La prueba «Minimizar y Mostrar la ventana» de la vitrina comprueba que reaparece con el mismo tamaño y la misma escala. **Esto se reemplazó en la v2.12.9** (ver arriba): animar el `UIScale` tampoco evita el relayout.
* **Iconos que aparecían tarde al bajar rápido.** El motor descarga cada imagen la primera vez que se dibuja. Ahora los iconos se piden en segundo plano, por lotes chicos y sin repetir el mismo asset, justo después de crearse. Se apaga con `AlanUI.Opciones.PrecargarIconos = false`.
* **Iconos con id vacío o `0`.** Ya no se le piden al motor (en Studio dejaba «ContentId: rbxassetid://0 failed» en la consola): se usa directo el `Respaldo` si lo hay.

### 🆕 Opciones nuevas

* **`AlanUI.Opciones.TransparenciaEnControles`** (`false` por defecto). Con `true`, la transparencia de la ventana (`CrearVentana({ Transparencia })` o el slider de Apariencia) se extiende, más suave (60 % del valor), a las filas de los controles y a las barras de los sliders, incluidos los que se creen después. No toca los modales ni los controles que ya tienen su propia transparencia. Con `false` queda como antes: solo el fondo, la barra de título y la barra lateral.
* **`AlanUI.Opciones.PrecargarIconos`** (`true` por defecto). Ver arriba.

Las opciones pasan a ser 18.

### 🧪 Vitrina

* **Cobertura completa.** Se agregaron pruebas para todo lo que no tenía: `Minimizar`/`Mostrar`, los eventos `FlagCambiada` y `TipoCambiado`, `RecalcularDerivadosEntorno`, `PuedeDeshacer`/`PuedeRehacer`, `Registrar`, `RegistrarInstancia`, `RegistrarDibujo`, `DesconectarYLimpiar`, `GuardarConfiguracion`/`CargarConfiguracion`, `SM:ListarUI`, `Seccion:Construir`, y las claves `MostrarCancelar`, `Proporcion`, `Separacion`, `AnchoMinimo`, `Escala`, `ImagenEscala`, `MaxCaracteres`, `OcultarContador`, `Decimales`, `Prefijo`, `Orientacion`, `PosicionInicial`, `TamanoMiniX`, `TamanoMiniY` y `Transparencia`. Las opciones `AtajosHistorial`, `GuardarPosicionVentana`, `PrecargarIconos` y `TransparenciaEnControles` tienen su interruptor en la sección de Opciones.
* **Sin repetidos.** Se fusionaron las pruebas de `DiagnosticoCompleto` (tres en una), `Profiler` (dos en una), flag duplicada y derivada del Texto, y perfil dañado y `Cargar`; la prueba de `Temas` absorbe la del tema Neon. Se quitaron las demostraciones duplicadas de tags, de cambio de tema y de notificaciones, y los controles repetidos de «Verificación de cambios recientes» (sus pasos de comprobación pasaron a los tooltips de los controles originales).


## 🆕 Novedades v2.12.7

Esta entrada reúne todo lo de la 2.12.6 y lo que se sumó en la 2.12.7. En conjunto trae cuatro cosas: el **modo Mini** y el cambio de modo en vivo, la **Preinstalada por módulos**, la **limpieza total al cerrar** y un conjunto de herramientas de **diagnóstico y validación**. **No se eliminó ni se renombró ningún método, parámetro, evento ni opción pública.** Los pocos cambios que pueden notarse en un script que ya existía están reunidos al final de esta sección, en "Qué cambió o se quitó".

> ℹ️ Este README describía la librería antes de que existiera el modo Mini, y por eso todo lo de Mini aparece aquí por primera vez. Los campos están documentados con sus valores reales, verificados contra el código.

### 🛠️ Correcciones

* **`Toggle` y `Casilla` con `Contenido`:** `Contenido = function(sub) sub:Slider("FOV", 0, 120, 90) end` agrega controles que aparecen debajo solo mientras el interruptor está activo (respeta el `VisibleSi` del propio control y se puede anidar). Los controles de `Columnas` aceptan ahora también la forma corta.
* **`AlanUI:Confirmar` con `Input`:** `Input = { Defecto = "", Placeholder = "", Area = false, Validar = function(texto) return ok, mensaje end, SoloLectura = false, Monoespaciado = false }` agrega un campo de texto. El texto llega como segundo argumento del `Callback` de los botones, y si `Validar` devuelve `false, "mensaje"` el modal sigue abierto y muestra el aviso. `ObtenerTexto()` está en el objeto devuelto.
* **Más claves en controles existentes:** `Slider` con `Formato = function(valor) return texto end` (por ejemplo `"50 FPS"`), `Divider` con `Alto` (8 a 120), `ColorPicker` con `Paleta = { Color3, ... }` (hasta 12 colores) y `CrearVentana({ Watermark = "Mi script | v1.0" })`, una etiqueta arrastrable que sigue al tema. Sin estas claves, nada cambia.
* **`Confirmar` con `Input`, botones de cancelar:** `Validar` se evalúa al presionar cualquier botón menos el de cancelar (`BotonCancelar`, o un botón de `Botones` con `Cancelar = true`), que cierra sin validar. Si `Validar` falla con un error, se registra y se deja pasar. El `Callback` de cada botón recibe `(marcada, texto)`.
* **`Divider` con `Texto` y `Alto`, `Slider` con `Formato`:** con `Texto`, el alto del `Divider` no baja de 38. Al escribir en la caja de un `Slider` con `Formato`, se toma el primer número del texto (`"75 FPS"` aplica 75).
* **ModoDev:** `Formato` y `Paleta` se reconocen como claves válidas. `OffsetHitboxY`, que ninguna parte de la librería leyó nunca, ya no figura entre ellas.
* **Mantenimiento:** `Columnas` y `Contenido` comparten una sola implementación de subsección (las columnas ahora aceptan la forma corta, que este README ya anunciaba). Se quitaron tres variables locales sin uso y un comentario sobre `OffsetHitboxY`. La vitrina suma dos pruebas: cancelar sin validar, y `Formato` escrito, `Divider` con `Texto`, tope de 12 en `Paleta` y columnas en forma corta.
* **Documentación corregida:** `AlanUI.Eventos.ControlRegistrado` figuraba como «reservado» y sí se dispara; las opciones son 16, no 15; los temas tienen 18 claves (14 base y 4 de estado); `ThemeManager:AplicarTema` no estaba documentado; `Watermark`, `Paleta`, `Formato`, `Alto` y `Contenido` se describen ahora también en la Referencia; el README en inglés se llevó a paridad con este.
* **Búsqueda sin acentos ni mayúsculas:** «configuracion» encuentra «Configuración», tanto en el buscador de la ventana como en el de los Dropdown. El texto de «Sin resultados» muestra lo que escribiste.
* **Nombres de guardado validados en todo `SaveManager`:** `Guardar`, `GuardarSilencioso`, `Cargar`, `CargarSilencioso`, `CambiarPerfil`, `Eliminar` y las de interfaz (`GuardarUI`, `CargarUI`, `EliminarUI`) rechazan nombres vacíos, de más de 60 caracteres o con `/ \ : * ? " < > |`. Devuelven `false` y lo dejan en `ObtenerErrores()`. Antes solo se validaba al duplicar, renombrar, exportar e importar.
* **Tocar afuera en cajas numéricas y de texto:** al soltar el foco sin pulsar Enter, `Slider` y `NumberStepper` aplican el número escrito si es válido y distinto, o restauran el anterior si no lo es. `Input` ejecuta su `Callback` al tocar afuera si el texto cambió, solo en dispositivos táctiles; en PC sigue siendo con Enter.
* **Eventos:** las conexiones desconectadas se descartan en el siguiente `Fire`, en vez de acumularse.
* **Colores de estado de temas propios:** un tema que no define `Exito`, `Aviso`, `Peligro` e `Info` recibe un juego neutro, claro u oscuro según su fondo, en lugar de copiar los de Negro.
* **`Notificar` sin interfaz:** con ModoDev avisa en consola que la notificación se descartó, en vez de no hacer nada.
* **Compatibilidad:** el `task.spawn` de respaldo para ejecutores antiguos conserva los argumentos. `Keybind` detecta el gamepad al crear cada control, no solo al cargar la librería.
* **Textos:** español neutro (sin voseo), tildes en los mensajes y «Cerrar la interfaz» en vez de «Eliminar la interfaz».
* **Pestañas y secciones igual de simples que los controles:** `CrearTab` y `CrearSeccion` aceptan también una tabla con `Texto` (por ejemplo `CrearTab({ Texto = "Principal", Icono = "@info" })` o `CrearSeccion({ Texto = "Combate", Colapsable = false })`) y tienen nombre por defecto si se llaman sin argumentos. La forma de siempre, con el nombre como texto, no cambia.
* **Atajos de teclado de la ventana (solo PC):** además de `TeclaToggle` (`RightControl`, minimiza y restaura como siempre), hay cuatro combinaciones activas por defecto: `RightShift+H` oculta o muestra toda la interfaz, `RightShift+R` resetea los valores del script (pide confirmación), `RightShift+L` llama a `AlReejecutar` y `RightShift+Q` cierra la interfaz (pide confirmación). Se cambian en `AlanUI.Opciones.Atajos` o por ventana con `CrearVentana({ Atajos = { Cerrar = "RightShift+X" } })`; `false` apaga una y `Atajos = false` apaga todas. Se usa `RightShift` porque pulsar `RightControl` solo ya minimiza: por la misma razón, `Ctrl+Z` y `Ctrl+Y` del historial conviene hacerlos con el Ctrl izquierdo. Las combinaciones salen listadas en «Teclas rápidas» de la pestaña Preinstalada.
* **Transparencia de la ventana:** `CrearVentana({ Transparencia = 0.2 })` y un slider nuevo en Apariencia (0 a 60 %, se guarda con los ajustes de interfaz). Hace translúcidos el fondo, la barra de título y la barra lateral; las filas de los controles quedan opacas para que se lean bien.
* **Indicador de pestaña deslizante:** al cambiar de pestaña, la barrita de acento se desliza desde la pestaña anterior en vez de aparecer de golpe, tanto en la barra lateral como en la horizontal.
* **Tamaño de las ventanas generadas desde otra:** una ventana que se crea mientras otra sigue abierta y no trae `TamanoX`/`TamanoY` propios hereda el tamaño base de la anterior, de modo que comparten la misma escala automática en pantalla. Antes nacía con 560×340, y una ventana con base más chica recibe un `UIScale` mayor que una grande, así que sus controles se veían más grandes. Un tamaño explícito sigue ganando.
* **Modal de cierre:** el modal «¿Cerrar la interfaz?» (antes «Eliminar») usa ahora `AlanUI:Confirmar` en vez de una copia aparte, así que sigue su diseño. El botón Cerrar toma la variante `danger`.
* **`SaveManager:Configurar(carpeta, carpetaUI)`:** segundo parámetro opcional para cambiar también la carpeta de ajustes de interfaz, que por diseño no sigue a la de los perfiles. Sin él, nada cambia.
* **`MarcarComoUI`:** una categoría desconocida (por ejemplo `"temp"`) avisa en ModoDev. Sin categoría o con `"ui"` sigue igual.
* **`CrearVentana({ Posicion = ... })`:** se acepta como alias de `PosicionInicial`.
* **Forma corta, activa por defecto:** `CrearVentana("Título")`, `Notificar("Título", "Texto")` y todos los controles con el `Texto` como primer argumento (por ejemplo `Seccion:Toggle("Modo Automático", false, callback)`). Un Toggle pasa de 6 líneas a 1 y una interfaz mínima cabe en 6. No hay interruptor: la tabla de siempre sigue funcionando igual, y la forma corta se suma. Se resuelve en un único punto por el que ya pasan todos los controles.
* **Lista maestra de controles:** los nombres de controles que se bloquean, reaccionan al modo Mini, van en Columnas, entran en el esquema o usan su Texto como Flag vivían en cinco listas distintas que ya se habían desincronizado. Ahora salen de una sola tabla. `Construir` va en Columnas pero no es un control, y `Grupo` queda fuera del esquema porque ese formato no puede expresar sus botones hijos. Los controles envueltos exponen también `Instancia`, además de `Fila`.
* **Alias:** `Locked` lee también `BloqueadoMotivo` (como `BloqueadoSi` ya leía `LockedTitle`) y `Label` acepta `Defecto` como alias de `Valor`. `Tooltip` (ayuda emergente) y `Descripcion` (panel desplegable) siguen siendo cosas distintas.
* **Avisos del desarrollador:** las advertencias de ModoDev se guardan además en una lista aparte (tope de 50) para que no desplacen errores reales. `AlanUI:ObtenerErrores()` devuelve lo de siempre, solo errores; `ObtenerErrores("aviso")` devuelve los avisos. En consola salen como «Aviso» y `DiagnosticoCompleto` los incluye en un bloque aparte. `AlanUI.DebugMode = true` activa ModoDev y los errores silenciados: es el interruptor único para ver todo; `MostrarErroresEnUI` solo afecta a los errores de Callback que aparecen en pantalla.
* **Opciones:** agrupadas por tema en el código y en este README (son 22), con `TextoFijo` y `AtajosHistorial` documentadas. En ModoDev, asignar una opción que no existe (por ejemplo `EstiloVisul`) avisa con sugerencia.
* **`NoGuardar`:** clave nueva de control (`NoGuardar = true`). Ese valor no se guarda en perfiles, no entra al historial y `Resetear` no lo toca, igual que Label y Progreso. `AlanUI:MarcarComoUI(flag, "temporal")` hace lo mismo desde fuera; sin segundo argumento sigue marcando como de interfaz. Como `MarcarComoUI`, se llama después de `CrearVentana`.
* **Cargar con un solo camino:** `SaveManager:Cargar`, `CargarSilencioso` y `CargarUI` comparten una sola implementación y mantienen sus firmas. Todas conservan la copia `.corrupto` ante un archivo ilegible (a `CargarUI` le faltaba), limpian el historial al terminar (`Cargar` no lo hacía, así que cargar un perfil quedaba como cambio deshacible), revisan los conflictos de Keybind y muestran un único aviso resumen si algún control no se pudo restaurar, en vez de uno por flag.
* **Preinstalada, `Excluir`:** `AgregarPestanaPreinstalada({ Excluir = { "Historial" } })` crea todos los módulos menos esos. `Modulos` conserva su significado («solo esos») y gana si se pasan los dos. `AgregarModuloPreinstalado` sigue colocando un módulo suelto en cualquier pestaña.
* **`AlanUI:Profiler({ PorClase = true })`:** además de los contadores de siempre, devuelve `PorClase`, una tabla `{ [ClassName] = cantidad }` con los objetos de la interfaz, para ver qué clases pesan más.
* **Rendimiento del texto:** el ajuste de tamaño de las etiquetas con `Truncar` estima el tamaño y verifica en pocos pasos en vez de probar un punto por vez, con el mismo resultado y menos llamadas a `TextService`. Con `Opciones.TextoFijo = true` ya no se conectan los listeners de tamaño y texto de cada etiqueta (la opción se lee al crear los controles).
* **Temas:** todos los temas traen ahora colores semánticos `Exito`, `Aviso`, `Peligro` e `Info` (más oscuros en Blanco para que contrasten). Un tema que no los defina recibe los de Negro, en vez de heredar los del tema anterior. Hay tres temas nuevos: `Oceano`, `Ambar` y `Medianoche`, que aparecen solos en el selector.
* **Notificaciones y pestaña Sistema:** los tipos `Success`, `Warning` y `Error` y los estados de Rendimiento, Salud y Funciones toman sus colores del tema activo.
* **Tooltips:** si el panel no cabe debajo del «?», se coloca encima.
* **Historial:** `Ctrl+Z` deshace y `Ctrl+Y` o `Ctrl+Shift+Z` rehace, con una notificación breve. Se puede desactivar con `AlanUI.Opciones.AtajosHistorial = false`. No actúan mientras se escribe en un campo de texto.
* **Persistencia:** si un perfil tiene un JSON inválido, `SaveManager:Cargar` y `CargarSilencioso` guardan una copia como `.corrupto` y avisan, en vez de dejar que el siguiente autoguardado lo pise.
* **Observabilidad:** `DiagnosticoCompleto()` devuelve también `Historial`, `ErroresRegistrados` y `UltimoAutoguardado`, y el reporte de texto los incluye.
* **Splash:** el texto «AlanUI» sigue el color del tema.
* **Registro de tema:** había dos funciones `compactarRegistro` con firmas distintas y la llamada del registro de tema caía en la de 2 argumentos, lo que producía un error dentro del handler de destrucción y dejaba crecer el registro. La de 1 argumento pasa a llamarse `compactarRegistroMarcado`.
* **`AlanUI.Eventos.ControlRegistrado`** ahora se dispara al terminar de crearse cada control, con una tabla `{ Tipo, Flag, Texto }` (`Flag` es nil si el control no tiene).
* **`SaveManager:CargarSilencioso(nombre, sinNotificar)`:** segundo argumento opcional para no mostrar la notificación. `CrearVentanaConSeguridad` lo usa al cargar antes del modal «Nuevo script detectado».
* **`CrearVentana({ ScriptId = "..." })`:** campo opcional. Si no hay `NombreConfig`, se usa el `ScriptId` (sin caracteres inválidos) como `NombreConfig`, y `CrearVentanaConSeguridad` lo usa para la preferencia «No volver a preguntar». Sin `ScriptId` todo sigue igual.
* **`AlanUI:Profiler({ Marca = "x", CompararCon = "y" })`:** marcas con nombre para comparar contra una lectura anterior (máximo 20, se descartan las más viejas). `Profiler()` y `Profiler(true)` no cambian.
* **Autoguardado:** `GuardarSilencioso` no escribe si el archivo ya tiene exactamente el mismo contenido.
* Nueva opción `AlanUI.Opciones.TextoFijo` (por defecto `false`). Con `true`, los textos con `Truncar` mantienen su tamaño en vez de encogerse para caber; si no caben, se cortan con «…». Así las pestañas y los valores de las filas conservan el mismo tamaño de letra. La vitrina la activa.
* `Label`: el registro en `AlanUI.Elementos[flag]` ahora también expone `SetColor` y `SetTexto`, igual que el control devuelto por `:Label()`. Antes solo tenía `Set` y `Get`, y llamar `AlanUI.Elementos["sys_rendimiento"].SetColor(...)` (la fila de Rendimiento de la Preinstalada) daba `attempt to call a nil value` en cada ciclo.
* Vitrina: la primera línea cargaba la propia vitrina en vez de la librería y no asignaba `AlanUI`, lo que causaba `attempt to index nil with 'Opciones'`. Ahora carga `AlanUI.lua` y lo guarda en `AlanUI`.

### 📱 Modo Mini

`CrearVentana({ Mini = true })` crea una interfaz compacta, pensada para scripts con pocos controles:

- **Tamaño:** 260 px de ancho por defecto (`TamanoMiniX`). El **alto es automático**: se ajusta al contenido de la pestaña, con un mínimo de 94 px y un máximo de `AlturaMaximaMini` (440 por defecto, y nunca más del 90 % de la pantalla). Con `TamanoMiniY = 400` el alto queda fijo; con `TamanoMiniY = "auto"` se fuerza el automático. En una ventana que **nace** en Mini, `TamanoX` y `TamanoY` también se leen como tamaño Mini cuando no pasas `TamanoMiniX` / `TamanoMiniY`.
- **Escala:** `EscalaMini` (de 0.4 a 1.5). Sin ella, la escala es 0.6 en pantallas chicas y 0.85 en las demás, y la ventana nunca ocupa más del 94 % del ancho de la pantalla. Se puede cambiar en vivo con `Ventana:CambiarEscalaMini`.
- **Sin barra de pestañas ni buscador.** Solo es accesible la primera pestaña (la primera que no sea la Preinstalada).
- **Controles compactos:** los `Slider`, `RangeSlider`, `NumberStepper` e `Input` usan cajas de valor más angostas, y los márgenes bajan de 12 a 6 px (10 px entre secciones en lugar de 22).
- **Encabezado propio:** una flecha ▲/▼ junto al título, y a la derecha los botones **💾 Guardar** (guarda la configuración y avisa con una notificación), **⤢ Expandir** (solo si la ventana permite cambiar de modo), **— Minimizar** y **✕ Cerrar**. El subtítulo y los tags no se muestran.
- **Se pliega con un toque:** tocar el título (un toque corto, sin arrastrar) pliega la ventana hasta dejar solo el encabezado y la vuelve a desplegar. Arrastrar el encabezado mueve la ventana. `Plegado = true` la hace nacer plegada. Si no pasas `Plegado`, se recuerda si la dejaste plegada, junto con la posición (necesita `GuardarPosicion` activo y soporte de archivos).
- **Bordes arrastrables:** tiras de 8 px en el borde izquierdo, derecho e inferior permiten mover la ventana sin buscar el encabezado. Vienen activas en las ventanas Mini o alternables; `BordesArrastrables = true` las activa también en modo completo y `false` las quita.
- **`AutoCargar`:** carga la configuración guardada al abrir. Por defecto es `true` en Mini y `false` en modo completo; puedes forzarlo en cualquiera de los dos.
- **Preinstalada:** en Mini no se agrega la pestaña completa (consume espacio); si quieres uno de sus módulos, colócalo con `Ventana:AgregarModuloPreinstalado`.
- **Posición:** en una ventana que nace en Mini se recuerda aparte de la del modo completo (el archivo lleva el sufijo `_mini`).

```lua
local Ventana = AlanUI:CrearVentana({
    Titulo = "Mi Script",
    NombreConfig = "MiScript",
    Mini = true,
    PermiteAlternarModo = true,   -- opcional: es true por defecto en Mini
})
local Tab = Ventana:CrearTab("Principal", "🏠")
local Sec = Tab:CrearSeccion("Controles", { Colapsable = false })

Sec:Toggle({ Texto = "Activar", Flag = "activo", Defecto = false })
Sec:Slider({ Texto = "Velocidad", Flag = "vel", Min = 0, Max = 100, Defecto = 50 })
Sec:Toggle({ Texto = "Solo en completo", Flag = "extra", VisibleEnMini = false })
```

**`VisibleEnMini = false`** oculta un control mientras la ventana está en modo Mini (y lo muestra al volver al modo completo). Lo aceptan los 18 controles, `Divider`, `Parrafo` y también `Tab:CrearSeccion(nombre, { VisibleEnMini = false })`, que oculta la sección entera.

### 🔁 Cambiar de modo en vivo

- **`PermiteAlternarModo`** (por defecto `true` en Mini, `false` en completo): permite que la ventana pase de un modo a otro **sin recrearse**. En modo completo aparece el botón ⤡ junto al de minimizar; en Mini, el ⤢.
- **`Ventana:CambiarModo("mini")`** / **`Ventana:CambiarModo("completo")`** devuelve `true` si inició el cambio y `false` si no (ya estaba en ese modo, hay una animación en curso, o la ventana está minimizada; y si la ventana no permite alternar, además avisa en consola). Un modo distinto de `"mini"` / `"completo"` también avisa y devuelve `false`. **`Ventana:ObtenerModo()`** devuelve `"mini"` o `"completo"`.
- **`TamanoXCompleto` / `TamanoYCompleto`** (560 / 340): tamaño al que crece una ventana que nació Mini. Y al revés, `TamanoMiniX` / `TamanoMiniY` es el tamaño al que se reduce.
- Al pasar a completo se crea la Preinstalada si todavía no existía (salvo `PestanaPreinstalada = false`); al pasar a Mini se selecciona la primera pestaña que no sea la Preinstalada. Los controles con `VisibleEnMini = false` se ocultan o reaparecen solos.

### 🎛️ Funciones de pliegue y escala (modo Mini)

| Función | Qué hace |
|---|---|
| `Ventana:Plegar()` / `Ventana:Desplegar()` / `Ventana:AlternarPliegue()` | Pliega o despliega la ventana. No hacen nada en modo completo. |
| `Ventana:EstaPlegada()` | `true` si está en Mini y plegada; `false` en cualquier otro caso. |
| `Ventana:CambiarEscalaMini(valor)` | Cambia `EscalaMini` en vivo (0.4 a 1.5). Con `nil` vuelve a la escala automática. Devuelve `false` si la ventana no está en Mini. |

### 🧩 Preinstalada por módulos

La pestaña Preinstalada ahora se arma con **cinco módulos**, y cada uno se puede pedir por separado:

| Módulo | Qué trae |
|---|---|
| `Sistema` | Ejecutor, versión, rendimiento (FPS, tiempo de frame y semáforo), memoria, salud, diagnóstico del entorno, un selector para forzar el tipo de dispositivo y las teclas rápidas. |
| `Apariencia` | Tema, orientación, tamaños, borde, y recordar/resetear la posición. |
| `Configuracion` | Guardar / cargar / eliminar los ajustes de la propia interfaz. |
| `Perfiles` | Perfiles de script: guardar, cargar, eliminar, duplicar, renombrar, exportar e importar. |
| `Historial` | Deshacer / Rehacer. |

```lua
-- Solo dos módulos en la pestaña automática:
AlanUI:CrearVentana({ Titulo = "Mi Script", PestanaPreinstalada = { Modulos = { "Sistema", "Perfiles" } } })

-- O un módulo suelto, dentro de tu propia pestaña (también sirve en Mini):
local Tab = Ventana:CrearTab("Ajustes", "⚙️")
Ventana:AgregarModuloPreinstalado(Tab, "Perfiles")
```

- `Ventana:AgregarModuloPreinstalado(pestaña, nombre)` devuelve la pestaña, o `nil` con un aviso en consola si el primer argumento no es una pestaña, el módulo no existe, o ya se creó en otra pestaña (**un módulo se crea una sola vez por ventana**).
- `Ventana:AgregarPestanaPreinstalada({ Modulos = {...} })` crea la pestaña con esos módulos. Sin `Modulos` trae todos los que todavía no existan, y devuelve `nil` si no queda ninguno.
- La pestaña automática sigue existiendo en las ventanas de modo completo, igual que antes.

### 🧹 Cierre limpio

- La ✕, `Ventana:Destruir()` y la re-ejecución del script ahora limpian **lo mismo y por completo**: conexiones, hilos, objetos `Drawing`, instancias registradas y las GUIs propias.
- Además se sueltan las **conexiones que la librería crea una sola vez al cargarse** (el tamaño de la pantalla, el arrastre global y el reloj que actualiza los `Label` automáticos). Así, con la interfaz cerrada no queda nada escuchando cada movimiento del mouse ni cada frame. Si después se llama de nuevo a `CrearVentana`, se vuelven a enganchar solas.
- Es **seguro llamarlo dos veces**, y destruir una ventana vieja cuando ya existe una nueva **no toca** los registros de la nueva. El hilo que ejecuta la limpieza (por ejemplo, un callback que llama a `Destruir()`) no se cancela a sí mismo.
- **Qué se conserva a propósito:** los valores de `AlanUI.Flags` (un script que sigue corriendo puede seguir leyéndolos). `AlanUI.Elementos` sí se vacía. **Qué sigue siendo tuyo:** las conexiones que crees sin pasar por `RegistrarConexion` y compañía, que la librería no conoce.

### 🩺 Diagnóstico y validación

- **`AlanUI:Profiler(true)`** compara los contadores con la última vez que lo llamaste y agrega el campo `Comparacion` al resultado. Ver [Profiler bajo demanda](#-profiler-bajo-demanda-alanuiprofiler).
- **`AlanUI:DiagnosticoCompleto(true)`** arma un reporte de texto listo para pegar en un reporte de bug (versión, build, modo, ejecutor, entorno, funciones soportadas, **todas las `AlanUI.Opciones`**, Profiler y los últimos 5 errores) y lo copia al portapapeles. Esta función existía pero no estaba documentada: ver [`AlanUI:DiagnosticoCompleto`](#-alanuidiagnosticocompleto).
- **Aviso automático de Flag repetida:** si dos controles usan la misma `Flag`, la consola avisa que el primero deja de ser accesible con `ObtenerElemento`. No cuesta nada y está siempre activo.
- **`AlanUI.Opciones.ModoDev = true`** (apagado por defecto): al crear cada control avisa de las claves que la librería no conoce, con sugerencia (`Defaut` → «¿quisiste decir `Defecto`?»). También avisa si un `Set` de un `Dropdown` en modo `Multi` recibe opciones que no existen. `AlanUI.DebugMode = true` lo activa también.

### ✨ Mejoras en controles y opciones

- **`Dropdown`:** `Placeholder` (texto cuando no hay selección; sin él sigue diciendo "Ninguno") y `ObtenerOpciones()` (devuelve una **copia** de la lista actual).
- **`Slider` y `RangeSlider`:** `Sufijo` ahora puede ser una **función** `(valor) -> texto`, para sufijos que cambian con el valor (por ejemplo " m" hasta 1000 y " km" después). Con un texto fijo funciona igual que siempre.
- **`AlanUI.Opciones.MaxColaNotificaciones`** (`50`): tope de la cola de notificaciones que esperan lugar, para que un script que notifica en bucle no llene la memoria. `0` = sin tope.

### 🔧 Parámetros nuevos en controles y notificaciones

Todos son opcionales: sin ellos, cada control se comporta exactamente como antes.

| Parámetro | Dónde | Qué hace |
|---|---|---|
| `SoloAlSoltar = true` | `Slider`, `RangeSlider` | El valor, los Flags y el texto se actualizan en vivo mientras arrastras, pero el `Callback` se llama **una sola vez, al soltar**, con el valor final (y solo si el valor cambió). Útil para callbacks pesados: remotes, HTTP, cálculos. |
| `Callback` dentro de una opción | `Dropdown` | Una opción enriquecida (`{ Titulo = "Curar", Callback = function(opcion, marcada) ... end }`) puede traer su propio `Callback`; se ejecuta **después** del `Callback` general. |
| `Id` | `AlanUI:Notificar` | Si llega una notificación con el mismo `Id` que otra todavía visible, **actualiza esa tarjeta** (texto y temporizador) en lugar de apilar otra. Si la otra todavía espera en la cola, reemplaza su contenido. |
| `BloqueadoSi` / `BloqueadoMotivo` | cualquier control | Una función que devuelve `true` para **bloquear** el control (igual que `Lock()`) mientras se cumpla. Se evalúa al crear el control y cada vez que cambia un Flag, igual que `VisibleSi`. |
| Tema `Neon` | `AlanUI.ThemeManager` | Casi negro, acento rojo neón y texto de alto contraste. Aparece en el selector de temas. Solo cambia colores: la forma de las esquinas no es parte de un tema. |

```lua
SeccionAjustes:Slider({ Texto = "Distancia", Min = 0, Max = 500, Defecto = 100, SoloAlSoltar = true,
    Callback = function(v) RemoteDeAjuste:FireServer(v) end })      -- una llamada por gesto, no cien

SeccionAjustes:Dropdown({ Texto = "Acción", Opciones = {
    { Titulo = "Curar",  Callback = function(op, marcada) print(op, marcada) end },
    { Titulo = "Atacar", Callback = function(op) end },
}})

AlanUI:Notificar({ Id = "descarga", Titulo = "Descarga", Texto = "Paso 3/5" })   -- si "descarga" sigue visible, se actualiza

SeccionAjustes:Slider({ Texto = "Alcance", Min = 0, Max = 100, Defecto = 50,
    BloqueadoSi = function() return not AlanUI.Flags["modo_manual"] end,
    BloqueadoMotivo = "Activa el modo manual" })
```

**Detalle de `BloqueadoSi`:** solo desbloquea lo que él mismo bloqueó. Un control que nace con `Locked = true` (o que bloqueaste a mano con `Lock()`) no se desbloquea porque la condición deje de cumplirse. Si la función falla, se registra el error y el control no se bloquea.


### 🎨 Estilo visual moderno (opcional)

`AlanUI.Opciones.EstiloVisual` (o `CrearVentana({ EstiloVisual = "moderno" })` para una sola ventana) elige entre `"clasico"` (el aspecto de siempre, **por defecto**) y `"moderno"`. El moderno cambia **solo lo visual**; ningún control, función ni evento se comporta distinto.

| Elemento | Clásico | Moderno |
|---|---|---|
| Botón de ayuda `?` | Círculo azul macizo | Círculo tenue con el signo en el color de acento; se enciende al pasar el cursor. El área para tocarlo no cambia (20 px), y no se oculta en táctil. |
| Botón de cerrar `✕` | Roja siempre | Gris; se pone roja al pasar el cursor o al tocarla. |
| Pestaña activa | Tinte suave (0.88) | Píldora: tinte más marcado (0.78) y esquinas totalmente redondeadas. |
| Notificaciones | Se cierran solas por tiempo | Con mouse, el temporizador se **pausa** mientras el cursor está encima y sigue al salir. En táctil no hay pausa. |
| Buscador | Texto "🔍 Buscar..." | "Buscar..." con una lupa vectorial (sin emoji). |
| Estados del módulo Sistema (rendimiento, salud, funciones soportadas) | Emojis 🟢 🟡 🔴 | Un punto "●" y el valor pintado del color del estado. |
| Espacio entre secciones | 22 px entre secciones y 12 px entre controles | 26 px y 14 px (no cambia en las ventanas Mini ni en las que pueden alternar a Mini). |

```lua
AlanUI.Opciones.EstiloVisual = "moderno"            -- para todas las ventanas que crees después
-- o solo para una:
local Ventana = AlanUI:CrearVentana({ Titulo = "Mi Script", EstiloVisual = "moderno" })
```

Lo que **no** cambia, a propósito: `AlanUI.Opciones.IconosPropios` sigue apagado por defecto (que los iconos carguen depende de que sus assets estén aprobados en Roblox; si no cargan se ve el emoji), las alturas de fila (cada control fija la suya, pensada para el tamaño mínimo de toque) y los bordes (las filas ya no llevan borde: solo la ventana y unos pocos elementos pequeños). El estilo se lee **al crear la ventana**; para cambiarlo hay que volver a crearla.


### 🐛 Correcciones

- **`ObtenerElemento(flag):Set(v)` con dos puntos fallaba** (tomaba la tabla del elemento como valor y lo rechazaba). Ahora `Set` acepta tanto `elem.Set(v, ...)` como `elem:Set(v, ...)`, igual que el objeto que devuelve cada control.
- **Un control con `Flag` repetida perdía su valor por defecto:** al reemplazar a otro sin pasar por el registro, `Resetear()` no lo restablecía. Ahora se registra con su propio valor por defecto. El aviso de Flag repetida cubre además la `Flag` derivada del `Texto`.
- **Tres carreras entre temporizadores y animaciones:** el tiempo de espera de la captura de un `Keybind` podía cancelar una captura **nueva** (y soltar su conexión); colapsar y expandir una sección varias veces seguidas dejaba que un temporizador viejo tocara la animación actual; y volver a pulsar un botón `Async` antes de que terminara el giro anterior dejaba dos bucles de giro a la vez. Los tres usan ahora un número de generación que invalida a los anteriores.
- **Los registros de conexiones e hilos crecían sin límite** con lo que se usa muchas veces (un botón `Async`, la captura de un `Keybind`): cada entrada ya muerta seguía anotada hasta cerrar la ventana. Ahora, cada 64 altas, se descartan las que ya terminaron. No cambia lo que se limpia al cerrar.
- **`Ventana:Destruir()` y la ✕ no desconectaban las conexiones registradas** hasta la siguiente llamada a `CrearVentana`. Ahora las limpian de inmediato (ver "Cierre limpio").
- **`Ventana:Destruir()` sobre una ventana vieja** (cuando ya existía una nueva) vaciaba los registros de la ventana nueva. Ya no.
- **`SM:CargarUI`** restauraba flags de interfaz aunque su control no existiera; con la Preinstalada por módulos (o sin ella, en Mini) eso podía dejar valores sueltos. Ahora solo restaura los flags cuyo control existe.
- **`Orientacion = "horizontal"`** ya no se ignora cuando la ventana nace en Mini: se respeta al pasar a modo completo.
- **Documentación:** este README decía "17 tipos de control", pero son 18; y la tabla de `AlanUI.Opciones` omitía `BordeAdaptativo`, `MicroInteracciones`, `ClickDirectoEnBarras` e `IconosPropios`. Corregido.

### ⚠️ Qué cambió o se quitó (v2.12.6)

**Nada de la API pública se eliminó.** Lo que sigue son cambios internos de la pestaña Preinstalada y de valores por defecto del modo Mini, que solo afectan a un script que ya leía esos controles por su `Flag` o confiaba en esos valores:

- **Flags eliminados de la Preinstalada:** `sys_fps`, `sys_frametime`, `sys_estado` y `diag_ejecutor`. El rendimiento ahora es **un solo `Label`** con el flag `sys_rendimiento` (por ejemplo `60 FPS · 16 ms · 🟢`), y el ejecutor aparece una sola vez (`sys_exec`). Si tu script leía alguno de los flags eliminados con `ObtenerElemento`, usa `sys_rendimiento`.
- **De 7 secciones a 5 módulos:** "Información", "Diagnóstico del entorno" y "Atajos de teclado" se fusionaron en el módulo **Sistema**. "Configuración" pasó a llamarse "Configuración de la interfaz".
- **Las teclas rápidas muestran la tecla real:** antes decían siempre "RightCtrl"; ahora muestran la que definiste con `TeclaToggle`.
- **`Ventana._pestanaSistema`** apunta a donde se creó el módulo Sistema, y puede ser `nil` si no se creó.
- **El alto por defecto del modo Mini es automático** (en la versión intermedia sin documentar era fijo, de 440 px). Para el alto fijo anterior: `TamanoMiniY = 440`.

---


## 📚 Referencia de la API

### Elementos (van dentro de una Sección)

> ✍️ **Forma corta (v2.12.7):** todos los controles aceptan el `Texto` como primer argumento en vez de una tabla. Las funciones se toman como `Callback` y los demás valores van en este orden. La tabla de siempre sigue funcionando igual.
>
> | Control | Orden de los argumentos |
> |---|---|
> | `Boton` | `("Texto", callback)` |
> | `Toggle`, `Casilla`, `Input`, `TagInput`, `ColorPicker`, `Keybind`, `Progreso` | `("Texto", defecto, callback)` |
> | `Slider`, `RangeSlider`, `NumberStepper` | `("Texto", min, max, defecto, callback)` |
> | `Dropdown`, `RadioGroup` | `("Texto", opciones, defecto, callback)` |
> | `Label` | `("Texto", valor)` |
> | `Parrafo` | `("Título", "Contenido")` |
>
> Ejemplo: `Seccion:Dropdown("Arma", {"Espada", "Hacha"}, "Espada", function(v) print(v) end)`. Sin `Flag`, el `Texto` hace de Flag, como siempre.
>
> Un `nil` ocupa su lugar: `Slider("Vel", nil, 100)` deja `Min` por defecto y fija `Max`. Los campos opcionales (`Tooltip`, `VisibleSi`, `Locked`...) van en la forma de tabla.

> 🧠 **Antes de empezar — 4 palabras que vas a ver en TODOS los elementos:**
>
> - **`Flag`** — es el "nombre de identificación" único de ese control. Con ese nombre AlanUI guarda y recupera su valor (por ejemplo, si el usuario activó un Toggle, el Flag es lo que permite recordarlo y restaurarlo la próxima vez que se abra el script). Es como la etiqueta de una caja: sin etiqueta no sabes qué hay adentro ni puedes volver a encontrarla. Si no le pones uno, AlanUI le asigna uno automático, pero entonces no podrás acceder a ese valor fácilmente desde tu código — **siempre es buena práctica ponerle uno tú mismo**, en minúsculas y sin espacios (ej. `"auto_modo"`).
> - **`Defecto`** — es el valor inicial con el que aparece el control la primera vez que se abre la interfaz, antes de que el usuario lo toque. `Defecto = false` en un Toggle significa que empieza apagado; `Defecto = 16` en un Slider significa que arranca en el número 16.
> - **`Callback`** — es la función que se ejecuta automáticamente cada vez que el usuario interactúa con el control. Aquí es donde tú escribes qué debe pasar cuando el usuario lo activa, mueve el slider, escribe algo, etc. El valor que el usuario acaba de elegir llega como parámetro dentro de esa función (en los ejemplos se le suele llamar `estado`, `valor` o `v` — el nombre lo eliges tú).
> - **`Texto`** — es simplemente lo que se ve escrito en pantalla junto al control.

> 🔀 **Además, CUALQUIER elemento acepta `VisibleSi` (opcional, v2.7+):** una función que devuelve `true` o `false`. Si devuelve `false`, la fila entera se oculta — pensado para que un control dependa del estado de otro (ej. "Distancia" solo visible si "Auto Farm" está activo). Se re-evalúa automáticamente cada vez que cualquier flag cambia, sin que tengas que declarar de cuál depende. Ver el ejemplo completo en "Novedades v2.7" más arriba.

> 📱 **Y también `VisibleEnMini` (opcional, v2.12.6):** cualquier control, `Divider` o `Parrafo` acepta `VisibleEnMini = false` para ocultarse mientras la ventana está en modo Mini y reaparecer en modo completo. Ver [Modo Mini](#-modo-mini).
>
> 🔒 **Y `BloqueadoSi` (opcional, v2.12.6):** igual que `VisibleSi`, pero en vez de ocultar la fila la **bloquea** (con el mismo aspecto y la misma API que `Lock()`) mientras la función devuelva `true`. `BloqueadoMotivo` es el texto que se muestra como motivo.

> 💬 **Y también `Tooltip` (opcional, universal):** cualquier control acepta `Tooltip = "texto de ayuda"` — un círculo "?" (o mantener presionado en mobile) que muestra ese texto. No es exclusivo de ningún control puntual, funciona en Toggle, Slider, Dropdown, Boton, Input, RadioGroup, Progreso, ColorPicker y Keybind.

> 🔒 **Y también `Locked` / `LockedTitle` (opcional, v2.12.5+):** los controles interactivos (`Boton`, `Toggle`, `Casilla`, `Slider`, `RangeSlider`, `NumberStepper`, `Input`, `TagInput`, `Dropdown`, `RadioGroup`, `ColorPicker`, `Keybind`) aceptan `Locked = true` para nacer bloqueados, con `LockedTitle = "Requiere VIP"` como motivo visible. Ver "Bloqueo y resaltado de controles" más abajo.

#### 0. CrearSección (contenedor de controles)

`Tab:CrearSeccion(nombre, cfg)` agrupa controles relacionados dentro de una pestaña. Por defecto la sección es colapsable (ver Novedades v2.12).

**Segundo parámetro opcional (`cfg`):**

| Campo | Efecto |
|---|---|
| `Colapsable` | `false` desactiva el colapso: el header vuelve a ser un texto simple, idéntico al comportamiento anterior a v2.12. Default: `true`. |
| `ColapsadaPorDefecto` | `true` hace que la sección arranque colapsada. Solo tiene efecto si la sección es colapsable. Default: `false`. |
| `VisibleEnMini` | `false` oculta la sección entera mientras la ventana está en modo Mini (v2.12.6). Default: visible. |

```lua
local Seccion = Tab:CrearSeccion("Combate")                       -- colapsable (default)
local Fija    = Tab:CrearSeccion("Notas", { Colapsable = false }) -- header solo-texto
local Avanzada = Tab:CrearSeccion("Debug", { ColapsadaPorDefecto = true })
```

#### 1. Toggle (Interruptor)
Interruptor de dos estados (encendido/apagado), ideal para activar/desactivar funciones continuas — por ejemplo, un modo que corre todo el tiempo hasta que lo apagas.

```lua
SeccionCombate:Toggle({
    Texto = "Auto Modo",       -- Lo que ve el usuario junto al interruptor
    Flag = "auto_modo",        -- ID único para guardar/recuperar este valor
    Defecto = false,           -- Empieza apagado
    Callback = function(estado)
        -- "estado" llega como true o false, según si el usuario lo prendió o apagó
        print("Auto Modo:", estado)
    end
})
```

> 🆕 **Exclusión mutua con `Desactivar`:** tanto `Toggle` como `Casilla` aceptan `Desactivar = {"otroFlag1", "otroFlag2"}` — una lista de Flags de **otros** Toggle/Casilla que se apagan automáticamente cuando este se enciende. Es el patrón que la gente busca para hacer algo tipo "Farm / PvP / Raid" donde solo uno puede estar activo a la vez. Tres detalles importantes:
> - Solo funciona **entre** `Toggle` y `Casilla` — no aplica a `RadioGroup`, `Dropdown` ni ningún otro control (para eso, `RadioGroup` ya es selección única por diseño).
> - Solo dispara en la dirección de **encendido**: apagar este control no vuelve a encender nada.
> - El `Callback` del control que se apaga **sí se ejecuta** (recibe `false`) — no es un apagado silencioso.
>
> ```lua
> SeccionCombate:Toggle({
>     Texto = "Modo Farm", Flag = "modo_farm",
>     Desactivar = {"modo_pvp", "modo_raid"},
>     Callback = function(v) print("Farm:", v) end,
> })
> ```

> 🆕 **Atajo de teclado con `Tecla`:** tanto `Toggle` como `Casilla` aceptan `Tecla = Enum.KeyCode.X` para que el usuario pueda alternar el control con una tecla, además de tocarlo con el mouse/dedo.
>
> ```lua
> SeccionCombate:Toggle({ Texto = "Auto Modo", Flag = "auto_modo", Tecla = Enum.KeyCode.F })
> ```

> 🆕 **Controles que aparecen solo con el interruptor activo (`Contenido`, v2.12.7):** `Toggle` y `Casilla` aceptan `Contenido = function(sub) ... end`. Dentro, `sub` crea controles (con la forma de siempre o la forma corta) que viven en un marco propio debajo de la fila y se ven solo mientras el control está activo. Respeta el `VisibleSi` del propio control y se puede anidar.
>
> ```lua
> SeccionCombate:Toggle({
>     Texto = "Aimbot", Flag = "aimbot",
>     Contenido = function(sub)
>         sub:Slider("FOV", 0, 120, 90)
>         sub:Toggle({ Texto = "Predicción", Flag = "aimbot_pred" })
>     end,
> })
> ```

#### 2. Slider (Barra de ajuste)
Ajuste numérico dentro de un rango, suave y con límites definidos.

```lua
SeccionCombate:Slider({
    Texto = "Velocidad de Caminado (WalkSpeed)",
    Min = 16,
    Max = 500,
    Incremento = 5,      -- El valor salta de 5 en 5 (ej: 16, 21, 26...). Por defecto es 1.
    Sufijo = " studs/s",  -- Texto que se agrega despues del numero mostrado (ej: "120 studs/s")
    Defecto = 16,
    Callback = function(valor)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = valor
    end
})
```

> 🆕 **Marcas de escalón con `Pasos`:** agregando `Pasos = true`, el Slider dibuja marcas divisorias visuales por cada valor que cae en un múltiplo de `Incremento` — útil para que el usuario vea de un vistazo dónde caen los "escalones" en rangos con pocos pasos posibles (ej. `Min=0, Max=100, Incremento=25` dibuja marcas en 0, 25, 50, 75, 100).

> 🆕 **Manija (v2.12.5+):** el `Slider` muestra un círculo al final del relleno para ver dónde está el valor. Su tamaño sigue la altura de la barra. `Manija = false` lo quita.

> 🆕 **`Sufijo` como función (v2.12.6):** además de un texto fijo, `Sufijo` puede ser una función `(valor) -> texto`, para sufijos que cambian con el valor. Si la función falla o no devuelve un texto, simplemente no se muestra sufijo. Con una función, lo que el usuario escribe en la caja se interpreta quitando el texto no numérico del final (`1500 km` → `1500`).

> 🆕 **`Formato` (v2.12.7):** `Formato = function(valor) return valor .. " FPS" end` reemplaza por completo el texto de la caja de valor (en vez de «número + `Sufijo`»). Al escribir en la caja se toma el primer número del texto, así que `"75 FPS"` aplica 75. Si la función falla o no devuelve texto, se usa el formato de siempre.
>
> ```lua
> SeccionCombate:Slider({
>     Texto = "Distancia", Min = 0, Max = 2000, Incremento = 10, Defecto = 500,
>     Sufijo = function(v) return v >= 1000 and " km" or " m" end,
> })
> ```

> 🆕 **`SoloAlSoltar = true` (v2.12.6):** el `Callback` se llama una sola vez, al soltar la barra, con el valor final. El valor, los Flags y el texto siguen actualizándose en vivo. Escribir en la caja o llamar a `Set` no cambia nada: esos caminos siguen disparando el `Callback` al instante, como siempre.

#### 3. Dropdown (Menú desplegable)
Lista de opciones seleccionables. Si tiene más de 8 opciones, agrega buscador automáticamente (no es configurable manualmente — es siempre por ese umbral).

```lua
SeccionCombate:Dropdown({
    Texto = "Método de Movimiento",
    Opciones = {"Tween", "Set PrimaryPart CFrame", "Instant Teleport", "Safe Jump"},
    Defecto = "Tween",   -- Cuál opción viene seleccionada al abrir la interfaz
    Callback = function(opcionSeleccionada)
        print("Método activo:", opcionSeleccionada)
    end
})
```

> ⚠️ **Nota sobre `Defecto = "Tween"`:** "Tween" acá es solo uno de los textos de `Opciones`, no una animación que AlanUI ejecute — `Defecto` siempre debe ser un string que ya exista en `Opciones`. Es tu `Callback` el que decide qué hacer según la opción elegida.

> 🆕 **Selección múltiple con `Multi`:** agregando `Multi = true`, el usuario puede marcar varias opciones a la vez. Con `Multi`, `Defecto` deja de ser un string suelto y pasa a ser una **tabla** de las opciones que empiezan marcadas, y el `Callback` recibe una tabla (`{opcion = true, ...}`) en vez de un string.
>
> ```lua
> SeccionCombate:Dropdown({
>     Texto = "Efectos activos",
>     Opciones = {"Fuego", "Hielo", "Veneno"},
>     Multi = true,
>     Defecto = {"Fuego"}, -- tabla, no string
>     Callback = function(seleccionados)
>         for efecto, activo in pairs(seleccionados) do print(efecto, activo) end
>     end
> })
> ```

> 🆕 **Opciones enriquecidas (v2.12.5+):** cada entrada de `Opciones` puede ser, además de un string, una tabla `{ Titulo = "Espada", Descripcion = "Daño alto", Icono = "⚔️", Locked = true, LockedTitle = "Nivel 20" }`. Una entrada `{ Tipo = "Divider" }` dibuja una línea separadora entre grupos de opciones. Los títulos duplicados se ignoran con una advertencia. Las opciones bloqueadas se ven con 🔒 y su motivo, y no se pueden elegir.
>
> ```lua
> SeccionCombate:Dropdown({
>     Texto = "Arma",
>     Opciones = {
>         "Puños",
>         { Tipo = "Divider" },
>         { Titulo = "Espada", Descripcion = "Daño alto", Icono = "⚔️" },
>         { Titulo = "Hacha",  Descripcion = "Lenta", Locked = true, LockedTitle = "Nivel 20" },
>     },
>     Defecto = "Puños",
> })
> ```

> 🆕 **`Placeholder` (v2.12.6):** el texto que se muestra mientras no hay nada elegido. Sin él sigue diciendo "Ninguno". Funciona igual con `Multi`.
>
> ```lua
> SeccionCombate:Dropdown({ Texto = "Arma", Opciones = { "Espada", "Arco" }, Placeholder = "Elige un arma..." })
> ```

> ⚠️ **`Set` en modo `Multi` espera una tabla `{ Opcion = true }`**, la misma forma que devuelve `Get` y que recibe el `Callback`. `Defecto` sí acepta una lista (`{ "Fuego" }`), pero pasarle una lista a `Set` no selecciona nada. Con `AlanUI.Opciones.ModoDev = true`, `Set` avisa por consola si recibe una lista o nombres que no están en `Opciones` (no los filtra: se guardan igual).


> 🆕 **`Callback` por opción (v2.12.6):** una opción enriquecida puede traer su propio `Callback`, que recibe `(nombreDeLaOpcion, marcada)` y se ejecuta **después** del `Callback` general. En modo `Multi`, `marcada` indica si la opción quedó marcada o desmarcada. Un error en ese `Callback` se registra y no impide que el menú se cierre.
>
> ```lua
> SeccionCombate:Dropdown({ Texto = "Acción", Opciones = {
>     { Titulo = "Curar", Callback = function(op, marcada) print(op, marcada) end },
>     "Sin callback propio",
> }})
> ```


#### Opciones dinámicas del Dropdown
Un `Dropdown` puede cambiar su lista de opciones **después** de creado — útil para listas que dependen del juego (jugadores, armas, perfiles guardados). El control devuelto expone cinco funciones:

```lua
local dd = SeccionCombate:Dropdown({ Texto = "Objetivo", Opciones = { "Ninguno" }, Defecto = "Ninguno" })

dd.ActualizarOpciones({ "Ana", "Beto", "Carla" })  -- reemplaza TODA la lista
dd.AgregarOpcion("Dani")                            --> true  (false si es texto vacío o ya existe)
dd.EliminarOpcion("Beto")                           --> true  (false si no estaba)
dd.LimpiarOpciones()                                -- deja la lista vacía
dd.ObtenerOpciones()                                --> copia de la lista actual (modificarla no afecta al control)
```

- `AgregarOpcion` y `EliminarOpcion` aceptan llamada con `.` o con `:`. **`ActualizarOpciones` y `LimpiarOpciones` se llaman con punto** (`dd.ActualizarOpciones(lista)`), igual que en el resto de la librería.
- `AgregarOpcion` solo agrega **textos**. Para opciones con descripción, ícono o bloqueo (ver "Opciones enriquecidas"), usa `ActualizarOpciones` con la lista completa.
- Si la opción elegida **ya no está** en la nueva lista, la selección se vacía (el `Flag` queda en `nil`) y **no se ejecuta el `Callback`**. En modo `Multi` se conservan solo las opciones que siguen existiendo.
- Los botones que siguen existiendo se reutilizan: solo se crean o destruyen los que cambiaron.
- Si la lista supera cierto tamaño, aparece sola la caja de búsqueda.

#### 4. Boton (Botón)
Ejecuta una función inmediatamente al hacer clic.

```lua
SeccionCombate:Boton({
    Texto = "Ejecutar Acción",
    Callback = function()
        print("Acción ejecutada.")
    end
})
```

> 🆕 **Icono opcional (v2.10+):** agregando `Icono = "💾"` (un emoji o caracter unicode) obtienes un botón tipo "💾 Ejecutar Acción" — simplemente se antepone al texto, sin crear ninguna instancia extra.

> 🆕 **Texto a la derecha con `Interact` (v2.12.5+):** `Interact = "Ctrl+K"` muestra un texto corto a la derecha del botón (en color de acento). El control devuelto expone `SetInteract(texto)` y `GetInteract()` para cambiarlo en vivo.

> 🆕 **Ejecución asíncrona con `Async`:** agregando `Async = true`, mientras el `Callback` está corriendo se muestra un spinner de carga en el botón y se bloquea contra taps repetidos (si el usuario vuelve a tocar mientras ya está corriendo, no pasa nada) — útil para Callbacks que tardan (una petición HTTP, leer/escribir un archivo grande).
>
> ```lua
> SeccionCombate:Boton({
>     Texto = "Sincronizar datos",
>     Async = true,
>     Callback = function()
>         task.wait(2) -- algo que tarda
>     end
> })
> ```

#### 5. Keybind (Tecla asignable)
Permite que el usuario asigne (o reasigne) una tecla del teclado para disparar una acción, sin que tú tengas que programar esa lógica de captura — AlanUI ya la trae integrada.

```lua
SeccionCombate:Keybind({
    Texto = "Activar función",
    Defecto = Enum.KeyCode.E,   -- Tecla con la que empieza asignada (el usuario puede cambiarla)
    Callback = function(tecla)
        -- Se llama cada vez que se "presiona" la tecla asignada
        print("Tecla presionada.")
    end
})
```

> ⌨️ **¿Cómo funciona exactamente? (respondiendo tu pregunta):**
>
> Sí — si el script corre en **PC**, AlanUI **sí detecta automáticamente** las teclas del teclado físico. Así es el flujo:
>
> 1. El elemento aparece mostrando la tecla actual (por ejemplo, "E") en un botoncito.
> 2. El usuario le da clic a ese botón. Esto pone al Keybind en "modo escucha".
> 3. La **siguiente tecla** que el usuario presione en su teclado se captura automáticamente y se asigna como la nueva tecla — no hace falta que tú escribas ningún código para esto, ya viene resuelto dentro de la librería.
> 4. A partir de ahí, cada vez que el usuario presione esa tecla en el juego, se ejecuta tu `Callback`.
>
> **Caso especial — cuando NO hay teclado físico (celular sin control conectado):** el código de AlanUI detecta si el dispositivo tiene teclado o gamepad disponible. Si no hay ninguno de los dos (celular con solo pantalla táctil), el Keybind deja de esperar una tecla —que nunca llegaría— y el botón se convierte automáticamente en un botón de acción directa: cada toque en pantalla equivale a "presionar" la tecla asignada. Esto es completamente automático, no tienes que configurar nada distinto para móvil.

> 🆕 **Combinaciones con modificadores (v2.9+):** agregando `ConModificadores = true`, el valor pasa de ser un `Enum.KeyCode` suelto a una tabla `{KeyCode, Ctrl, Shift, Alt}` — útil para atajos como "Ctrl+Shift+F". Ver el ejemplo completo en "Novedades v2.9" más arriba.

> 🆕 **El `Callback` no se dispara al asignar (v2.11.2+):** asignar o reasignar la tecla **no** ejecuta el `Callback` — solo presionarla después en el juego lo hace. Si necesitas reaccionar también en el momento exacto de la asignación, escucha `AlanUI.Eventos.FlagCambiada` para ese flag en particular.

> ⚠️ **Detección de conflictos (v2.11.2+):** si asignas una tecla que ya está en uso por otro `Keybind` de la misma ventana, aparece una notificación avisando cuál — no se bloquea la asignación ni se toca el otro `Keybind` automáticamente, ambos quedan con la misma tecla. También se revisa al cargar un perfil guardado que ya tenía el conflicto.

> 🆕 **Modos de tecla — `Modo` (v2.12.5+):** el `Callback` puede recibir la tecla (como siempre), el estado de "mantener presionada" o un estado que alterna.
>
> ```lua
> SeccionCombate:Keybind({ Texto = "Agacharse", Flag = "agacharse", Defecto = Enum.KeyCode.C, Modo = "Hold",
>     Callback = function(presionada) print(presionada and "abajo" or "arriba") end })
>
> local kb = SeccionCombate:Keybind({ Texto = "Modo vuelo", Flag = "vuelo", Defecto = Enum.KeyCode.V, Modo = "Toggle",
>     Callback = function(encendido) print("Vuelo:", encendido) end })
> print(kb.GetEstado(), AlanUI:ObtenerFlag("vuelo_estado"))
> ```
>
> | `Modo` | El `Callback` recibe | Notas |
> |---|---|---|
> | `"Press"` (default) | la tecla asignada | Como siempre. |
> | `"Hold"` | `true` al presionar y `false` al soltar | En celular sin teclado, "mantener" es mantener el dedo sobre el botón (en este modo el toque largo ya no rota la tecla). |
> | `"Toggle"` | `true` / `false` alternando en cada pulsación | La tecla asignada sigue siendo el valor del Flag (se guarda como siempre). El estado vive en el flag `"<Flag>_estado"`, que **no** se guarda en perfiles. El control devuelto agrega `GetEstado()` y `SetEstado(bool)`. |
>
> En `"Hold"` y `"Toggle"` el `Callback` habla de **estado**, así que asignar o restaurar una tecla (por ejemplo al cargar un perfil) **no** lo ejecuta. El título de la fila muestra `[Hold]` o `[Toggle]`. Un modo desconocido avisa por consola y usa `"Press"`.

#### 6. ColorPicker (Selector de color)
Abre un sub-menú para elegir un color RGB personalizado.

```lua
SeccionCombate:ColorPicker({
    Texto = "Color Principal",
    Defecto = Color3.fromRGB(255, 0, 0),
    Callback = function(nuevoColor)
        print("Nuevo color seleccionado:", nuevoColor)
    end
})
```

> 🆕 **Campo Hex (v2.9+):** debajo de los sliders R/G/B hay un campo `#RRGGBB` (también acepta `#RGB`) que se sincroniza en ambas direcciones con los sliders — no requiere ninguna opción extra en el código, ya viene incluido.

> 🆕 **Paleta de colores comunes (v2.10+):** arriba de los sliders hay una fila de 8 swatches (rojo, verde, azul, amarillo, magenta, cian, blanco, negro) — un click aplica el color de una vez. Tampoco requiere ninguna opción extra.

> 🆕 **`Paleta` (v2.12.7):** `Paleta = { Color3.fromRGB(255, 0, 0), ... }` reemplaza los 8 colores comunes por los tuyos (hasta 12; los que sobren se ignoran, y si ninguno es un `Color3` se usan los de siempre).

> 🆕 **`Estilo = "2D"` (v2.12.5+):** además del estilo de siempre (`"RGB"`), el `ColorPicker` puede mostrar un **cuadrado de saturación/valor** y una **barra de matiz**, manteniendo el campo Hex y las muestras.
>
> ```lua
> SeccionCombate:ColorPicker({ Texto = "Color 2D", Flag = "color2d", Estilo = "2D", Defecto = Color3.fromRGB(220, 90, 90) })
> AlanUI.Opciones.ColorPickerEstiloPredeterminado = "2D" -- para los ColorPicker que se creen después sin 'Estilo'
> ```
>
> Es **opcional**: sin `Estilo` se usa `AlanUI.Opciones.ColorPickerEstiloPredeterminado`, que por defecto es `"RGB"`. El panel 2D es más alto (170 px en vez de 126). Mientras arrastras dentro del cuadrado la página no hace scroll, y el matiz se conserva al pasar por grises o negro.

#### 7. Casilla (Checkbox)
Alternativa visual al Toggle: una casilla clásica para marcar o desmarcar.

```lua
SeccionCombate:Casilla({
    Texto = "Activar Función Segura",
    Flag = "funcion_segura",
    Defecto = false,
    Callback = function(valor)
        print("Casilla marcada:", valor)
    end
})
```

#### 8. Párrafo informativo
Elemento puramente visual, para notas, advertencias o créditos.

```lua
SeccionCombate:Parrafo({
    Titulo = "⚠️ ADVERTENCIA",
    Contenido = "Usa este script bajo tu propio riesgo.",
    RichText = false -- soporta texto enriquecido si se activa
})
```

> 🆕 **Campos extra de `Parrafo` (v2.12.5+):** `ImagenUrl` (banner arriba del texto, con `ImagenAlto` entre 40 y 300, default 110, y `ImagenEscala = "Fit"` o recorte por defecto), `MiniaturaUrl` (miniatura a la derecha) y `Botones = { { Texto, Variante, Callback }, ... }` (fila de botones debajo del texto; `Variante` puede ser `"primary"` o `"danger"`). Las imágenes se pasan como `rbxassetid://...`. El control devuelto expone `Set(texto)`, `Instancia` y `Botones`.

#### 9. Label (Etiqueta de solo lectura)
Muestra un texto informativo con un valor a la derecha que puedes actualizar por código (por ejemplo, un contador de FPS o un estado). No es interactivo para el usuario — se actualiza con `Set()`.

```lua
local lblEstado = SeccionCombate:Label({
    Texto = "Estado del servidor",
    Flag = "estado_servidor",
    Valor = "Conectando..."
})

-- Más adelante, en tu script:
lblEstado.Set("Conectado ✅")
print(lblEstado.Get()) --> "Conectado ✅"
```

> 🆕 **`Descripcion` (v2.12.5+):** `Label` acepta `Descripcion = "texto largo"` — aparece una flecha a la izquierda de la fila que despliega/oculta ese texto explicativo debajo. `Parrafo` también acepta `Descripcion` (texto secundario dentro del bloque).

#### 10. Input (Campo de texto)
Caja de texto editable por el usuario.

```lua
SeccionCombate:Input({
    Texto = "Nombre",
    Flag = "nombre",
    Defecto = "",
    Placeholder = "Escribe aquí...",
    Callback = function(valor)
        print("Texto ingresado:", valor)
    end
})
```

> 🆕 **Validación con `Tipo` (v2.9+):** `Tipo = "number"` (con `Min`/`Max` opcionales) o `Tipo = "pattern"` (con `Regex`) validan lo que el usuario escribe antes de aceptarlo. La validación y el `Callback` corren al perder el foco (`FocusLost` — típicamente presionando Enter o tocando fuera del campo), no en cada tecla mientras se escribe. Ver el ejemplo completo en "Novedades v2.9" más arriba.

> 🆕 **Límite de caracteres con `MaxCaracteres`:** por defecto el campo acepta hasta 200 caracteres; se puede ajustar con `MaxCaracteres = 50`, por ejemplo.

> 🆕 **Contador visible (v2.11.2+):** aparece un pequeño "180/200" en la esquina inferior derecha del campo cuando el texto llega al 80% de `MaxCaracteres` — por debajo de ese umbral no se muestra nada, para no generar ruido visual en campos cortos. Desactivable por completo con `OcultarContador = true`.

#### 11. RadioGroup (Selector horizontal)
Alternativa a Dropdown cuando hay pocas opciones (2-4 es el caso típico): todas quedan visibles en una fila, sin desplegar nada.

```lua
SeccionCombate:RadioGroup({
    Texto = "Modo",
    Flag = "modo",
    Opciones = {"Farm", "PvP", "Raid"},
    Defecto = "Farm",
    Callback = function(v) print("Modo:", v) end,
})
```

#### 12. Progreso (Barra de progreso)
Barra de solo lectura (no interactiva), para mostrar cooldowns, progreso de auto-farm, carga de datos, etc. Se actualiza con `Set(0-100)`.

```lua
local barra = SeccionCombate:Progreso({ Texto = "Progreso del farm" })
barra.Set(45) -- 45%
```

> ℹ️ **`Progreso` (y `Label`) nunca se guardan en disco:** aunque les pongas un `Flag`, son controles pensados para mostrar un valor que cambia todo el tiempo (progreso en curso, un contador), así que quedan excluidos del sistema de guardado por diseño — no tiene sentido "restaurar" un progreso a medio camino al reabrir el script.

#### 13. Divider (Separador de sección)
Separador visual liviano entre grupos de controles relacionados dentro de una sección — una línea delgada, opcionalmente con un título chico. Mucho más liviano que `Parrafo` (sin caja de fondo, sin padding) para este propósito.

```lua
SeccionCombate:Divider() -- linea simple
SeccionCombate:Divider({ Texto = "Ajustes avanzados" }) -- linea con titulo arriba
```

> 🆕 **`Alto` (v2.12.7):** `SeccionCombate:Divider({ Alto = 30 })` fija el alto del separador, de 8 a 120 píxeles (por defecto 18, o 38 con `Texto`). Con `Texto` no baja de 38.

#### 14. RangeSlider (Slider de rango)
Dos manijas en una misma barra, para elegir un **rango** (mínimo y máximo) en vez de un solo valor — ej. "distancia entre 20 y 80".

```lua
SeccionCombate:RangeSlider({
    Texto = "Distancia",
    Flag = "distancia",
    Min = 0, Max = 100, Incremento = 5, Sufijo = " studs",
    Defecto = { min = 20, max = 80 },
    Callback = function(rango)
        print(rango.min, rango.max)
    end,
})
```

- El valor (en el `Callback`, `Get()` y `AlanUI.Flags`) es una tabla `{ min = n, max = n }`. `Set` recibe esa misma forma.
- Sin `Defecto`, arranca con el rango completo (`Min`–`Max`) y avisa por consola. Si `Defecto.min > Defecto.max`, se intercambian solos.
- Mismas validaciones que `Slider`: `Min >= Max` ajusta `Max` a `Min + 1`; `Incremento <= 0` usa `1`; avisa si `Incremento` no divide el rango y el máximo no se puede alcanzar.

> 🆕 **`Sufijo` como función (v2.12.6):** igual que en el `Slider`: `Sufijo = function(v) return v >= 1000 and " km" or " m" end`. Cada extremo del rango lleva su propio sufijo (`200 m – 1500 km`).


> 🆕 **`SoloAlSoltar = true` (v2.12.6):** igual que en el `Slider`: el `Callback` recibe `{ min, max }` una sola vez por gesto, al soltar cualquiera de las dos manijas.


#### 15. TagInput (Lista de etiquetas)
Lista de textos libres mostrados como "chips" — ej. palabras clave, o nombres de jugadores a ignorar.

```lua
SeccionCombate:TagInput({
    Texto = "Jugadores ignorados",
    Flag = "ignorados",
    Placeholder = "Nombre y Enter...",
    MaxTags = 10,
    MaxCaracteres = 30,
    Defecto = { "Amigo1", "Amigo2" },
    Callback = function(lista)
        print(#lista, "etiquetas")
    end,
})
```

- El valor es un **array** ordenado (`{"Amigo1","Amigo2"}`), no un diccionario como el `Dropdown` con `Multi`.
- Se agregan escribiendo y presionando Enter (o tocando afuera). El separador es la **coma** — pegar `a,b,c` crea tres etiquetas; el espacio no separa.
- Los duplicados se descartan sin distinguir mayúsculas. `Backspace` con la caja vacía borra la última etiqueta.
- `MaxTags` limita la cantidad (sin límite si se omite); `MaxCaracteres` limita el largo del texto en la caja (default 200).

#### 16. NumberStepper (Contador numérico)
Campo numérico con botones **−** y **+**, para valores donde importa escribir o ajustar de a un paso (a diferencia del `Slider`, no es una barra).

```lua
SeccionCombate:NumberStepper({
    Texto = "Cantidad",
    Flag = "cantidad",
    Min = 1, Max = 99, Incremento = 1,
    Defecto = 10,
    Prefijo = "x", Sufijo = " uds",
    Callback = function(n) print("Cantidad:", n) end,
})
```

- Con el campo enfocado, las flechas ↑ / ↓ del teclado suben y bajan el valor.
- `Decimales` (opcional) fuerza la cantidad de decimales mostrados; si se omite se deduce de `Incremento` (`0.25` → 2 decimales).
- `Set(v)` ignora (con aviso en consola) cualquier valor que no sea `number`, y recorta/redondea al rango y al `Incremento`.

#### 17. Imagen
Muestra una imagen dentro de la sección. Roblox solo carga assets propios: usa `rbxassetid://...` — una URL web (`https://...`) no funciona y se avisa por consola.

```lua
local img = SeccionCombate:Imagen({
    Url = "rbxassetid://1234567890",
    Aspecto = "16:9",   -- o un número (1.78); si se omite, se usa Alto fijo
    Escala = "Crop",    -- "Fit", "Crop" o "Stretch"
    Radio = 8,
})
img.Set("rbxassetid://9876543210") -- cambia la imagen en vivo
```

Con `Aspecto` la altura se calcula sola según el ancho; sin él se usa `Alto` (entre 40 y 400, default 120). Por defecto, `Escala` es `"Crop"` si hay `Aspecto` y `"Fit"` si no.

#### 18. Grupo (botones en una misma fila)
Agrupa varios `Boton` lado a lado. Si el ancho disponible es menor a `AnchoMinimo` por botón, pasan a apilarse en vertical solos (útil en móvil).

```lua
local grupo = SeccionCombate:Grupo({ Alto = 32, AnchoMinimo = 120 })
grupo:Boton({ Texto = "Guardar",  Callback = function() end })
grupo:Boton({ Texto = "Cargar",   Callback = function() end })
grupo:Boton({ Texto = "Eliminar", Callback = function() end })
```

`Alto` se limita entre 26 y 60 (default 32); `AnchoMinimo` default 120. Cada `grupo:Boton(cfg)` acepta los mismos campos que `Seccion:Boton`.

#### 19. Construir (armar una sección desde una tabla)
`Seccion:Construir(lista)` crea varios controles de una sola vez a partir de una lista de tablas. Cada entrada lleva `Control = "NombreDelControl"` más los campos normales de ese control.

```lua
local elementos = SeccionCombate:Construir({
    { Control = "Toggle", Texto = "Auto Modo", Flag = "auto_modo", Defecto = false },
    { Control = "Slider", Texto = "Velocidad", Flag = "vel", Min = 0, Max = 100, Defecto = 50 },
    { Control = "Divider", Texto = "Avanzado" },
    { Control = "Boton",  Texto = "Aplicar", Callback = function() print("ok") end },
})
elementos.vel.Set(80)  -- por Flag
elementos[1].Set(true) -- o por posición
```

- Tipos válidos: `Boton, Toggle, Casilla, Slider, RangeSlider, NumberStepper, Input, TagInput, Dropdown, RadioGroup, ColorPicker, Keybind, Label, Progreso, Parrafo, Divider, Imagen`. Un tipo desconocido se omite con una advertencia.
- Devuelve una tabla indexada por **posición** y, si el control tiene `Flag`, también por **Flag**.
- Si la entrada no trae `Control` pero su campo `Tipo` es uno de los nombres de arriba, se usa `Tipo` como nombre del control.

#### 20. Columnas (dos columnas en una sección)
`Seccion:Columnas()` devuelve **dos sub-secciones**. Cada una acepta los mismos controles que una sección (`Boton`, `Toggle`, `Slider`, `Input`, `Dropdown`, `Grupo`, `Construir`...) y los pone en su columna.

```lua
local izq, der = SeccionCombate:Columnas({
    Proporcion  = 0.5,   -- ancho de la columna izquierda (0.15 a 0.85)
    Separacion  = 12,    -- píxeles entre columnas (0 a 40)
    MinimoAncho = 400,   -- por debajo de este ancho base, se apilan
})

izq:Toggle({ Texto = "A", Flag = "a" })
izq:Slider({ Texto = "Valor A", Flag = "va", Min = 0, Max = 100, Defecto = 40 })
der:Toggle({ Texto = "B", Flag = "b" })
der:Dropdown({ Texto = "Modo B", Flag = "mb", Opciones = { "Uno", "Dos" }, Defecto = "Uno" })
```

- `MinimoAncho` se mide en píxeles **base**, sin contar la escala de la interfaz. Con la ventana por defecto (560 px) las columnas suelen apilarse; con 640 px o más se ven lado a lado (aproximado: depende de los márgenes).
- Los controles se crean en la sección y se mueven a su columna, así que `Locked`, `VisibleSi`, `Tooltip` y la búsqueda funcionan igual.
- No se pueden anidar columnas dentro de una columna.

---

### Funciones de la Ventana

#### `Ventana:Buscar(texto)`
Filtra manualmente los controles visibles según el texto dado, igual que si el usuario escribiera en la barra de búsqueda. Útil si quieres disparar una búsqueda desde tu propio código (por ejemplo, un botón "buscar combos").

```lua
Ventana:Buscar("velocidad")
-- Deja visibles solo los controles cuyo Texto contenga "velocidad"

Ventana:Buscar("") -- Limpia el filtro y muestra todo de nuevo
```

#### `Ventana:CambiarOrientacion(modo)`
Cambia en caliente entre tabs laterales (`"vertical"`) y tabs en barra superior (`"horizontal"`), sin necesidad de recrear la ventana. Con la ventana ya visible, la barra que aparece entra deslizándose con un fade mientras el contenido se reacomoda.

```lua
Ventana:CambiarOrientacion("horizontal") -- tabs arriba
Ventana:CambiarOrientacion("vertical")   -- tabs al lado (default)
```

#### `Ventana:CambiarTema(nombre)`
Aplica uno de los temas nativos a toda la interfaz con una transición suave de colores, y muestra una notificación confirmando el cambio. Solo se animan los elementos visibles: lo que está en pestañas ocultas cambia directo.

```lua
Ventana:CambiarTema("Verde")
-- Cambia todos los colores de la interfaz al tema "Verde" y notifica al usuario
```

#### `Ventana:Minimizar()` / `Ventana:Mostrar()` / `Ventana:EstaVisible()`
Controlan la visibilidad de la ventana desde tu código, igual que la tecla `TeclaToggle`. `EstaVisible()` devuelve `true` si está abierta.

```lua
Ventana:Minimizar()
if not Ventana:EstaVisible() then Ventana:Mostrar() end
```

#### Modo Mini y cambio de modo (v2.12.6)
Referencia rápida. La explicación completa, con todos los parámetros, está en [Novedades v2.12.7](#-novedades-v2127).

| Función | Qué hace |
|---|---|
| `Ventana:CambiarModo("mini" \| "completo")` | Pasa la ventana de un modo al otro sin recrearla. Devuelve `true` si inició el cambio. Necesita `Mini = true` o `PermiteAlternarModo = true`. |
| `Ventana:ObtenerModo()` | Devuelve `"mini"` o `"completo"`. |
| `Ventana:Plegar()` / `Desplegar()` / `AlternarPliegue()` | Pliega o despliega la ventana Mini. No hacen nada en modo completo. |
| `Ventana:EstaPlegada()` | `true` solo si está en Mini y plegada. |
| `Ventana:CambiarEscalaMini(valor)` | Cambia la escala Mini en vivo (0.4 a 1.5); `nil` = automática. Devuelve `false` fuera de Mini. |
| `Ventana:AgregarModuloPreinstalado(pestaña, nombre)` | Coloca un módulo de la Preinstalada en una pestaña tuya. |

En modo Mini, `Ventana:Minimizar()` / `Mostrar()` siguen minimizando la ventana a la píldora de siempre; para plegarla usa `Plegar()`.


#### Posición de la ventana (v2.12.5+)
La ventana recuerda dónde la dejaste entre ejecuciones del mismo script.

| Función | Qué hace |
|---|---|
| `Ventana:ResetearPosicion()` | Vuelve al centro (o a `PosicionInicial`). |
| `Ventana:GuardarPosicion()` | Escribe la posición actual ya, sin esperar. Devuelve `true`/`false`. |
| `Ventana:CargarPosicion()` | Mueve la ventana a la última posición guardada. Devuelve `true`/`false`. |

- **Dónde se guarda:** en un archivo propio por script, `AlanUI/Config/_ui/posicion_<NombreConfig>.json`. No usa el archivo de ajustes de la Preinstalada (ese es global para todos los scripts y solo se escribe con su botón "Guardar"). Por eso conviene poner tu propio `NombreConfig`.
- **Cómo:** se guarda el desplazamiento respecto al centro como fracción de la pantalla, así que sobrevive a un cambio de resolución. Se escribe solo, un instante después de soltar la ventana.
- **Fuera de pantalla:** si la posición guardada deja la ventana (en parte) fuera de la pantalla, se corrige al abrir.
- **Reabrir con la tecla de toggle** (o el botón de minimizar) sigue devolviendo la ventana a su posición de inicio de la sesión, como siempre. La última posición se aplica al volver a ejecutar el script.
- **Sin soporte de archivos** no se recuerda nada. Se puede apagar con `GuardarPosicion = false` o, para todas las ventanas, con `AlanUI.Opciones.GuardarPosicionVentana = false`.
- **Preinstalada** (sección Apariencia): el toggle "📍 Recordar posición" y el botón "🎯 Resetear posición".

#### `Ventana:Resetear()`
Devuelve **todos** los controles de tu script a su valor `Defecto` (el que tenían al crearse), ejecutando sus `Callback`. No toca los ajustes de la pestaña Preinstalada ni controles de solo lectura (`Label`, `Progreso`).

#### `Ventana:AgregarTag(cfg)`
Agrega una pastilla de color en la barra de título, junto al título — útil para "BETA", la versión, o el estado. Acepta un string suelto (`Ventana:AgregarTag("BETA")`) o una tabla:

| Campo | Efecto |
|---|---|
| `Texto` | Texto de la pastilla. |
| `Icono` | Emoji/carácter opcional antepuesto al texto. |
| `Color` | `"info"` (default), `"success"`, `"warning"`, `"danger"`, `"neutral"`, un `Color3`, `"rainbow"` (arcoíris), o una tabla de 2+ `Color3` (degradado). |
| `Animar` | `true` hace girar el degradado; con `"rainbow"` anima por defecto salvo `Animar = false`. |
| `Callback` | Si se pasa una función, la pastilla se vuelve clickeable. |

Devuelve `{ Instancia, SetTexto(texto), SetColor(color, animar), Remover() }`. Si no hay espacio en la barra, las pastillas más antiguas se ocultan solas.

```lua
local tag = Ventana:AgregarTag({ Texto = "BETA", Color = "warning" })
tag.SetColor("success")
tag.SetTexto("v1.2")
```

#### `Ventana:AgregarDivisorSidebar(cfg)` / `Tab:CrearDivisor(cfg)`
- `Ventana:AgregarDivisorSidebar({ Texto = "Grupo" })` inserta una línea (con título opcional) **entre botones de pestaña** en la barra lateral/superior. Se coloca en el orden en que lo llamas respecto a `CrearTab`.
- `Tab:CrearDivisor({ Texto = "Título" })` inserta un divisor dentro de una pestaña, **al final** de lo que ya tiene (si la página es más larga que la pantalla, desplázate para verlo).

Si se crean con la ventana ya visible, el divisor crece desde cero con un fade y empuja suavemente a sus vecinos.

```lua
Ventana:AgregarDivisorSidebar({ Texto = "Avanzado" })
local TabX = Ventana:CrearTab("Debug", "🐞")
TabX:CrearDivisor({ Texto = "Herramientas" })
```

#### `Ventana:ConstruirDesdeSchema(schema)`
Arma pestañas, secciones y controles completos desde una sola tabla de datos. Usa `Seccion:Construir` internamente.

```lua
local elementos = Ventana:ConstruirDesdeSchema({
    Tabs = {
        {
            Nombre = "Principal", Icono = "🏠",
            Secciones = {
                {
                    Nombre = "Combate", ColapsadaPorDefecto = false,
                    Controles = {
                        { Control = "Toggle", Texto = "Auto Modo", Flag = "auto_modo" },
                        { Control = "Slider", Texto = "Velocidad", Flag = "vel", Min = 0, Max = 100, Defecto = 50 },
                    },
                },
            },
        },
    },
})
elementos.vel.Set(70)
```

Devuelve una tabla `Flag → control` con todos los controles creados que tengan `Flag`.

#### `Ventana:CrearTab(nombre, icono)` — formas del ícono
El segundo parámetro acepta: un emoji/carácter (`"🏠"`), un asset como string (`"rbxassetid://123"`), un número (se interpreta como ID de asset) o una tabla `{ Icono = ..., ColorIcono = Color3 }` para teñir un ícono de imagen. Si ya existe una pestaña con ese nombre, no se duplica: avisa con una notificación y devuelve la existente.

#### El objeto `Tab` que devuelve `CrearTab`
Además de `CrearSeccion` y `CrearDivisor`, el objeto tiene estos miembros, útiles para cambiar de pestaña por código o personalizarla:

| Miembro | Qué es |
|---|---|
| `Nombre` | El nombre con el que se creó la pestaña. |
| `Seleccionar()` | Muestra esta pestaña (como si el usuario la tocara). Se llama con **punto**: `Tab.Seleccionar()`. |
| `Pagina` | El `ScrollingFrame` con el contenido de la pestaña. |
| `Boton` / `BotonLat` | Botón de la barra lateral (`Boton` es un alias de `BotonLat`). |
| `BotonHoriz` | Botón de la barra superior (orientación horizontal). |
| `IndicadorLat` / `IndicadorHoriz` | La barra de color que marca la pestaña activa en cada orientación. |
| `Secciones` | Lista de las secciones creadas en esta pestaña. |

La ventana guarda todas sus pestañas, en orden de creación, en `Ventana.Tabs`.

```lua
local TabAjustes = Ventana:CrearTab("Ajustes", "⚙️")
TabAjustes.Seleccionar()                    -- abre esta pestaña por código
print(#Ventana.Tabs, TabAjustes.Nombre)
```

#### `Ventana:GuardarConfiguracion()` / `Ventana:CargarConfiguracion()`
Guarda o carga manualmente todos los Flags actuales en el archivo de configuración de esta ventana (el que definiste en `NombreConfig`). No es necesario llamarlas normalmente —el autoguardado ya lo hace solo— pero son útiles para un botón de "Guardar ahora" o "Restaurar" en tu propio script.

> ℹ️ **No confundir con el guardado de la pestaña Preinstalada (v2.8+):** estas dos funciones trabajan sobre el mismo archivo que usa el sistema de **perfiles de script** (los Flags de tu propio script). Los ajustes de la pestaña Preinstalada en sí (tema, tamaño de ventana, etc.) usan un sistema completamente aparte — `SM:GuardarUI()`/`CargarUI()` — que nunca se mezcla con este. Ver la sección "Pestaña Preinstalada" más abajo.

```lua
SeccionAjustes:Boton({
    Texto = "💾 Guardar ajustes ahora",
    Callback = function()
        Ventana:GuardarConfiguracion()
    end
})

SeccionAjustes:Boton({
    Texto = "📂 Restaurar última configuración",
    Callback = function()
        Ventana:CargarConfiguracion()
    end
})
```

---

#### 🔑 API pública de acceso rápido (`ObtenerFlag`, `Try`, `ObtenerElemento`)
Tres formas de leer el valor de un control desde cualquier parte de tu script, sin guardar la referencia del control tú mismo — solo necesitas el `Flag` que le pusiste.

```lua
-- ObtenerFlag: lee el valor crudo. Devuelve nil si el flag no existe.
local vel = AlanUI:ObtenerFlag("velocidad")

-- Try: como ObtenerFlag, pero con un valor de respaldo si no existe
-- (evita tener que chequear nil tú mismo).
local vel = AlanUI:Try("velocidad", 16)

-- ObtenerElemento: devuelve el objeto {Set, Get} completo del control,
-- no solo su valor -- útil si además quieres SETEARLO desde afuera.
local elemento = AlanUI:ObtenerElemento("velocidad")
if elemento then
    print(elemento.Get())
    elemento.Set(50, true) -- el segundo argumento dispara el Callback
end
```

---

### 📦 Funciones internas de arquitectura

#### 🔄 El proxy de `AlanUI.Flags`: escribir vs. `Elementos[flag].Set()`
`AlanUI.Flags` no es una tabla común — cada asignación (`AlanUI.Flags["algo"] = valor`) pasa por un proxy interno que:
1. Guarda el valor.
2. Marca "hay cambios sin guardar" (para el autoguardado, ver más abajo).
3. Dispara `AlanUI.Eventos.FlagCambiada`.

Lo que **no** hace es actualizar el control visual ni disparar su `Callback`. Para eso existe `AlanUI:ObtenerElemento(flag).Set(valor, dispararCallback)`, que sí mueve el control en pantalla y, si le pasas `true` como segundo argumento, también ejecuta el `Callback` como si el usuario lo hubiera tocado.

```lua
AlanUI.Flags["velocidad"] = 50                          -- guarda el valor, NO mueve el Slider en pantalla, NO llama al Callback
AlanUI:ObtenerElemento("velocidad").Set(50, true)        -- mueve el Slider Y llama al Callback
AlanUI:ObtenerElemento("velocidad").Set(50)              -- mueve el Slider, sin llamar al Callback
AlanUI:ObtenerElemento("velocidad"):Set(50)              -- también vale con dos puntos (desde v2.12.6)
```

En la práctica, casi siempre vas a usar `Set(valor, true)` cuando quieras cambiar un control desde tu propio código — escribir `AlanUI.Flags` directo es más para lectura/depuración que para modificar algo en caliente.

#### 💾 Cómo funciona el guardado automático
Cualquier cambio en un control (mover un Slider, tocar un Toggle) marca internamente "hay cambios sin guardar". Un ciclo de fondo revisa esa marca cada **10 segundos**: si hubo algún cambio real desde la última vez, guarda una vez; si no hubo nada, no toca el disco. Como respaldo, también se guarda al cerrar la ventana (por si el ciclo de 10s no llegó a correr antes de que el juego se cierre de golpe). No hace falta llamar nada de esto manualmente — está activo por defecto (ver `AutoGuardar` en `CrearVentana` para desactivarlo).

#### 📄 Formato de los archivos `.json` guardados
Si necesitas inspeccionar o migrar manualmente un archivo de guardado, la mayoría de los valores se guardan tal cual (números, strings, booleanos, tablas). Tres tipos necesitan un empaquetado especial porque no son serializables directo a JSON:

```jsonc
// Un Color3 (de un ColorPicker) se guarda asi:
{ "__color3": true, "R": 255, "G": 0, "B": 0 }

// Un Enum.KeyCode suelto (Keybind sin ConModificadores) se guarda asi:
{ "__enum": true, "EnumType": "KeyCode", "Name": "F" }

// Un Keybind CON ConModificadores se guarda asi:
{ "__keybindMods": true, "KeyCode": "F", "Ctrl": true, "Shift": false, "Alt": false }
```

AlanUI reconstruye estos tres formatos automáticamente al cargar — no hace falta hacer nada especial al leerlos desde tu propio código con `SM:Cargar()`.

> 🆕 **Campo `__version` (v2.11.2+):** todo `.json` guardado a partir de esta versión incluye un campo interno `__version` al principio del archivo, reservado para el sistema de guardado — no lo uses como nombre de un `Flag` propio. Sirve para que AlanUI pueda migrar automáticamente archivos de un formato viejo si el esquema cambia en el futuro. Los archivos guardados con versiones anteriores (sin este campo) se siguen leyendo con total normalidad.

#### 📱 Qué se adapta automáticamente en mobile
Ninguno de estos puntos requiere configuración: AlanUI detecta el dispositivo (vía `AlanUI.Capacidades`) y ajusta esto por su cuenta.
- **Tooltip:** se muestra manteniendo presionado (long-press) en vez de necesitar hover con mouse.
- **`Keybind`:** si no hay teclado ni gamepad, se convierte en un botón de acción directa (cada toque "presiona" la tecla asignada) en vez de esperar una tecla que nunca va a llegar.
- **Áreas táctiles:** los botones pequeños (cerrar, minimizar) tienen una zona de toque invisible más grande que su ícono visible.
- **`Slider`:** el área de toque real es más alta que la barra visual, para no depender de la precisión de un cursor de mouse.
- **Tamaño de texto:** el piso mínimo de la escala de texto sube de 6px a 9px (6px es ilegible en la mayoría de los celulares).
- **Splash de apertura:** la animación de apertura de la ventana es más corta (0.25s, ver Novedades v2.12.5).
- **Escala general:** la ventana se auto-ajusta a un porcentaje distinto del viewport según sea PC o mobile, para que ni se vea diminuta en un celular ni gigante en un monitor.

#### 🗑️ `Ventana:Destruir()` vs. el botón "✕"
Son dos caminos distintos a propósito:
- **`Ventana:Destruir()`** es instantánea, pensada para uso **programático** — tu propio script decidiendo cerrar la interfaz (por ejemplo, al terminar una tarea). No pregunta nada.
- **El botón "✕"** que ve el usuario pide confirmación antes de destruir — evita perder la sesión por un toque de más, algo especialmente fácil en mobile.

Ambos caminos hacen **la misma limpieza completa** (v2.12.6): desconectan las conexiones registradas, cancelan los hilos, quitan los `Drawing` y las instancias registradas, destruyen las GUIs propias, vacían los registros internos (temas, buscador, escala de texto, elementos) y sueltan las conexiones globales de la librería. No hay diferencia de comportamiento salvo la confirmación. Llamar a `Destruir()` dos veces es seguro.

#### ⚠️ Advertencias de desarrollo (automáticas)
AlanUI revisa la configuración de cada control **antes** de crearlo y avisa en la consola de Roblox (F9) si detecta un descuido común — sin usar `error()` nunca, para no romper tu script. Siempre corrige con un valor seguro y sigue funcionando.

No hace falta llamar nada: pasa solo con crear los controles normalmente.

```lua
-- Esto imprime un warn() en consola y usa Min (0) como valor inicial:
SeccionCombate:Slider({
    Texto = "Volumen",
    Min = 0, Max = 100,
    -- Defecto olvidado ⚠️
})

-- Esto imprime un warn() y ajusta Max automáticamente:
SeccionCombate:Slider({
    Texto = "Rango raro",
    Min = 50, Max = 10, -- Min >= Max ⚠️
    Defecto = 20,
})
```

Casos que se avisan actualmente:
- `Slider` sin `Defecto` → usa `Min`.
- `Slider` con `Min >= Max` → ajusta `Max` a `Min + 1`.
- Cualquier control con `Callback` presente pero que no es una función → se ignora.
- `Button` sin `Callback` → no tiene ninguna utilidad, se avisa siempre.
- **Flag repetida (v2.12.6):** dos controles con la misma `Flag` → avisa que el primero deja de ser accesible con `ObtenerElemento`. También avisa cuando **no pasas `Flag`** y dos controles usarían el mismo `Texto` como Flag (los controles que guardan valor la derivan del `Texto`). Siempre activo.
- **Claves desconocidas (v2.12.6, solo con `AlanUI.Opciones.ModoDev = true`):** una clave que la librería no conoce (por ejemplo `Defaut`) → avisa y sugiere la más parecida (`¿quisiste decir 'Defecto'?`). Revisa las claves de la config de cada control; no valida valores.
- **`Set` de un `Dropdown` `Multi` (solo con `ModoDev`):** avisa si recibe una lista en vez de `{ Opcion = true }` o nombres que no existen en `Opciones`.
- **Cola de notificaciones llena (v2.12.6):** avisa una sola vez cuando se alcanza `AlanUI.Opciones.MaxColaNotificaciones`.

> Esto es distinto de `AlanUI:ObtenerErrores()` (ver más abajo): ese sistema atrapa errores que tira tu propio `Callback` **en tiempo de ejecución**. Este validador revisa la **configuración** antes de que el control exista.

#### 🛠️ Captura de errores en Callbacks (`ObtenerErrores`)
Cada vez que un `Callback` tuyo tira un error mientras corre, AlanUI lo atrapa (no se cae la interfaz), muestra una notificación en pantalla y lo guarda en un registro consultable (últimos 50 errores).

```lua
-- Si este Callback tira un error, AlanUI lo atrapa solo:
SeccionCombate:Boton({
    Texto = "Acción riesgosa",
    Callback = function()
        error("Algo salió mal aquí")
    end,
})

-- En cualquier momento puedes revisar el historial:
local errores = AlanUI:ObtenerErrores()
for _, e in ipairs(errores) do
    print(e.Contexto, e.Mensaje)
end
```

#### 🐞 Modo Debug (`AlanUI.DebugMode`)
Por defecto (`false`) el comportamiento es el de siempre. En `true`, además de todo lo que ya se avisa por consola normalmente, ciertos `pcall` puntuales que hoy fallan **a propósito** en silencio (porque fallar ahí es esperable y avisar de cada uno sería ruido para el usuario final — ej. sincronizar el color de tema de un elemento ya destruido) también hacen `warn()`. Pensado para cuando estás probando tu propio script y quieres ver esos fallos "esperables" mientras desarrollas.

```lua
AlanUI.DebugMode = true
```

#### 📡 Eventos globales (`AlanUI.Eventos`)
Reaccioná a cambios importantes desde cualquier parte de tu script, sin tener que envolver manualmente cada control.

```lua
AlanUI.Eventos.FlagCambiada:Connect(function(flag, valor)
    print("Cambió:", flag, "→", valor)
end)

AlanUI.Eventos.TabCambiada:Connect(function(nombreTab)
    print("Pestaña activa:", nombreTab)
end)

AlanUI.Eventos.TemaCambiado:Connect(function(nombreTema)
    print("Tema aplicado:", nombreTema)
end)
```

Además, desde v2.11 y v2.12.5 existen `AlanUI.Eventos.TipoCambiado` (`function(tipo)`, al reclasificarse el dispositivo — rotar la pantalla, `ForzarTipo`) y `AlanUI.Eventos.HistorialCambiado` (`function(nDeshacer, nRehacer)`). `AlanUI.Eventos.ControlRegistrado` (`function({ Tipo, Flag, Texto })`) se dispara al terminar de crearse cada control; `Flag` es `nil` si el control no tiene.

`Connect` devuelve un objeto con `:Disconnect()` si en algún momento quieres dejar de escuchar:

```lua
local conexion = AlanUI.Eventos.FlagCambiada:Connect(function() end)
conexion.Disconnect()
```

#### 🔄 Sistema de auto-limpieza
Evita memory leaks: al volver a ejecutar tu script, AlanUI detecta si ya existe una interfaz activa y limpia todo antes de crear la nueva. Desde v2.12.6 la misma limpieza ocurre **al cerrar la ventana** (✕ o `Ventana:Destruir()`), sin esperar a una nueva ejecución.

```lua
-- Registra un hilo propio (task.spawn) para que se cancele
-- automáticamente si el script se re-ejecuta -- sin esto, el loop
-- viejo seguiría corriendo en paralelo con el nuevo para siempre.
local miHilo = task.spawn(function()
    while true do
        task.wait(1)
        print("Mi loop sigue corriendo...")
    end
end)
AlanUI:RegistrarHilo(miHilo)

-- Lo mismo aplica a conexiones propias (RunService, UserInputService, etc.):
local miConexion = game:GetService("RunService").Heartbeat:Connect(function() end)
AlanUI:RegistrarConexion(miConexion)
```

Hay 4 funciones de registro en total, una por tipo de recurso — usa la que corresponda:

| Función | Para qué |
|---|---|
| `AlanUI:RegistrarConexion(conexion)` | Conexiones de eventos (`:Connect(...)`) |
| `AlanUI:RegistrarHilo(hilo)` | Hilos propios (`task.spawn`, `task.delay`) |
| `AlanUI:RegistrarDibujo(objetoDrawing)` | Objetos `Drawing.new(...)` (líneas, cajas, texto de ESP, etc.) |
| `AlanUI:RegistrarInstancia(instancia)` | Cualquier `Instance` suelta que crees tú mismo (BillboardGui, Highlight, etc.) y que no cuelgue ya de la ventana |

Las 4 funciones devuelven el mismo recurso que reciben, así que también puedes registrar "en línea":

```lua
local dibujo = AlanUI:RegistrarDibujo(Drawing.new("Line"))
```

**Qué limpia al cerrar (v2.12.6):** todo lo registrado con las 4 funciones de arriba, más las conexiones que la librería crea una sola vez al cargarse (tamaño de pantalla, arrastre global, actualización de `Label` automáticos). Los valores de `AlanUI.Flags` se conservan; `AlanUI.Elementos` se vacía. Lo que **no** registres con esas funciones es tuyo: la librería no lo conoce y no puede limpiarlo. `AlanUI:Profiler(true)` ayuda a detectarlo.


#### 🔔 Notificaciones (Notificar)
Muestra un panel flotante en pantalla para avisos importantes (por ejemplo, cuando el script terminó de cargar).

```lua
AlanUI:Notificar({
    Titulo = "¡AlanUI Cargado!",
    Texto = "El script se ha ejecutado de forma exitosa.",
    Duracion = 5 -- segundos que dura en pantalla
})
```

**Parámetros opcionales (v2.7+):**

| Parámetro | Qué hace |
|---|---|
| `Tipo` | `"Info"` (por defecto), `"Success"`, `"Warning"` o `"Error"` — cada uno con su propio color de acento fijo (el de `Info` sigue el tema activo). |
| `Persistente` | `true` para que NO se cierre sola por tiempo — se descarta con un click/toque en cualquier parte de la tarjeta. |
| `Prioridad` | Número (por defecto `0`). Si ya hay 4 notificaciones en pantalla, una con `Prioridad` más alta salta adelante de las que están esperando con prioridad menor, en vez de irse siempre al final de la cola. |
| `Id` | Texto o número (opcional, v2.12.6). Si llega una notificación con el mismo `Id` que otra **todavía visible**, se actualiza esa tarjeta (título, texto y temporizador) en vez de crear otra; si la otra espera en la cola, se reemplaza su contenido. Sin `Id`, todo funciona como siempre. |

```lua
AlanUI:Notificar({
    Titulo = "Error crítico",
    Texto = "No se pudo cargar la configuración",
    Tipo = "Error",
    Prioridad = 2,
    Persistente = true, -- el usuario la cierra tocándola
})
```

**Cola de espera (v2.12.6):** las notificaciones que no caben en pantalla esperan en una cola. Su tope es `AlanUI.Opciones.MaxColaNotificaciones` (por defecto `50`, `0` = sin tope). Con la cola llena, una notificación con `Prioridad` mayor entra por delante y se descarta la última de la cola (la de menor prioridad; entre iguales, la más nueva). Si la que llega habría quedado al final, se descarta la que llega. Sin `Prioridad` todo es orden de llegada. Se avisa una sola vez por consola.


**Pausa al pasar el cursor (v2.12.6):** con `EstiloVisual = "moderno"` y mouse, el temporizador de una notificación se detiene mientras el cursor está encima (la franja de color se frena) y continúa con el tiempo que quedaba al salir. En táctil y en el estilo clásico no hay pausa.


#### 🎨 Selector de temas (AgregarSelectorTemas)
Agrega un botón en la barra lateral (o en la barra superior, si estás en modo horizontal) para que el usuario cambie entre los temas disponibles (Negro, Blanco, Verde, Morado, Rojo) con un clic. No acepta parámetros — no se puede colocar dentro de una sección, siempre va en la barra de navegación.

```lua
Ventana:AgregarSelectorTemas()
```

#### 🔧 Pestaña Preinstalada (`AgregarPestanaPreinstalada`)
**En modo completo se agrega sola, automáticamente, dentro de `CrearVentana`.** No necesitas llamarla tú mismo. Desde v2.12.6 se arma con **cinco módulos**:

| Módulo | Qué incluye |
|---|---|
| `Sistema` | Info del ejecutor y versión de AlanUI. **Rendimiento** en un solo indicador (FPS, tiempo de frame en ms y semáforo 🟢/🟡/🔴), memoria aproximada (si el ejecutor la expone) y estado de "Salud" (crecimiento de objetos/conexiones desde que se abrió la ventana). **Diagnóstico del entorno:** dispositivo detectado, funciones soportadas, advertencias específicas solo cuando falta algo y un selector para forzar el tipo de dispositivo. **Teclas rápidas**, con la tecla real que definiste en `TeclaToggle`. El monitor solo escribe mientras la pestaña y la ventana están visibles. |
| `Apariencia` | Selector de tema, orientación de tabs (vertical/horizontal), sliders de tamaño (escala general, ancho, alto, tamaño de texto), borde de la ventana (estilo, animación, grosor, colores) y "📍 Recordar posición" con "🎯 Resetear posición". |
| `Configuracion` | "Configuración de la interfaz": Guardar / Cargar / Eliminar, pero SOLO para los ajustes de la propia interfaz (tema, tamaño, orientación). No toca los Flags de tu script. |
| `Perfiles` | "Perfiles de script": Dropdown con los perfiles guardados + Guardar como nuevo + Cargar + Eliminar, para los Flags de TU script. Incluye Duplicar, Renombrar, Exportar e Importar. Completamente separado del módulo anterior. |
| `Historial` | "Historial de cambios": botones ↩️ Deshacer / ↪️ Rehacer con un contador de pasos disponibles. |

Si por alguna razón no la quieres (por ejemplo, tu script ya trae su propia pestaña de ajustes y no quieres duplicar), la desactivas así:

```lua
local Ventana = AlanUI:CrearVentana({
    Titulo = "Mi Script",
    PestanaPreinstalada = false, -- desactiva la pestaña automática
})
```

Puedes personalizarla sin desactivarla, pasando una tabla en vez de `false`:

```lua
local Ventana = AlanUI:CrearVentana({
    Titulo = "Mi Script",
    PestanaPreinstalada = {
        Nombre  = "⚙️ Sistema",                  -- cambia el nombre de la pestaña
        Modulos = { "Sistema", "Perfiles" },     -- solo estos módulos (en este orden fijo: Sistema, Apariencia, Configuracion, Perfiles, Historial)
    },
})
```

**Un módulo suelto, en tu propia pestaña** (v2.12.6) — también sirve en modo Mini, donde la pestaña completa no se agrega:

```lua
local Tab = Ventana:CrearTab("Ajustes", "⚙️")
Ventana:AgregarModuloPreinstalado(Tab, "Perfiles")   -- devuelve la pestaña, o nil con un aviso
```

- Un módulo se crea **una sola vez por ventana**: si ya está en otra pestaña, el segundo intento avisa y devuelve `nil`.
- `Ventana:AgregarPestanaPreinstalada({ Modulos = {...} })` se puede llamar a mano. Sin `Modulos` trae todos los que todavía no existan; devuelve `nil` si no queda ninguno por crear.
- `CargarUI` solo restaura los ajustes de los módulos que existen en la ventana.


#### 🏷️ `AlanUI:MarcarComoUI(flag)` (nuevo en v2.8)
Marca uno o más Flags como exclusivos de la interfaz — el sistema de perfiles de script (`SM:Guardar`/`Cargar`/`Listar`/`Eliminar`) jamás los incluirá ni los sobreescribirá. Es lo que usa internamente la pestaña Preinstalada para separar sus propios ajustes de los de tu script; rara vez necesitas llamarla tú mismo salvo que quieras agregar tus propios controles "de interfaz" (por ejemplo, un campo de texto para nombrar perfiles) que tampoco deban guardarse dentro de cada perfil.

```lua
SeccionTuya:Dropdown({
    Texto = "Selector interno (no es config de juego)",
    Flag = "mi_selector_ui",
    Opciones = {"A", "B", "C"},
})
AlanUI:MarcarComoUI("mi_selector_ui")
```

#### 💾 `SM:GuardarUI(nombre)` / `CargarUI(nombre)` / `ListarUI()` / `EliminarUI(nombre)` (nuevo en v2.8)
Las mismas cuatro operaciones que ya conocías del sistema de perfiles (`Guardar`/`Cargar`/`Listar`/`Eliminar`), pero operando exclusivamente sobre los Flags marcados con `MarcarComoUI` — en una carpeta separada, que nunca se mezcla con los perfiles de script. Es el sistema que usa internamente la sección "Configuración" de la pestaña Preinstalada.

```lua
AlanUI.SaveManager:GuardarUI("mis_ajustes_interfaz")
AlanUI.SaveManager:CargarUI("mis_ajustes_interfaz")
```

#### 🔎 `AlanUI.Capacidades` — qué soporta el ejecutor actual
Tabla de booleanos, calculada una sola vez al cargar la librería, para que tu script (o AlanUI internamente) pueda adaptarse al ejecutor sin asumir nada:

```lua
AlanUI.Capacidades.Archivos    -- true/false: soporte de writefile/readfile (necesario para guardado)
AlanUI.Capacidades.Drawing     -- true/false: soporte de Drawing.new()
AlanUI.Capacidades.ProtectGUI  -- true/false: GUI protegida (syn.protect_gui, protectgui o el contenedor oculto de gethui y sus alias)
AlanUI.Capacidades.GetHUI      -- true/false: soporte de gethui() o de sus alias get_hidden_gui y gethiddengui (para que la GUI sobreviva a un CoreGui bloqueado)
AlanUI.Capacidades.ArchivosCompletos -- true/false: isfile, isfolder, makefolder, delfile y listfiles además de writefile/readfile (v2.13.2)
AlanUI.Capacidades.Portapapeles      -- true/false: setclipboard o sus alias toclipboard y set_clipboard (v2.13.2)
AlanUI.Capacidades.NavegacionGamepad -- true/false: si el motor tiene activada la navegación de la GUI con D-pad o stick (v2.13.2)
AlanUI.Capacidades.Teclado     -- true/false: si el dispositivo tiene teclado fisico/bluetooth
AlanUI.Capacidades.Gamepad     -- true/false: si hay un gamepad conectado
```

`Teclado` y `Gamepad` son los que usa la propia librería para decidir si un `Keybind` puede esperar una tecla de verdad o debe convertirse en botón de acción directa (ver "Qué se adapta automáticamente en mobile" más arriba) — pero están disponibles para que tu propio script tome decisiones parecidas.

#### 🎞️ Ayudantes de animación (`AlanUI.Animaciones`)

Cuatro funciones sueltas para animar tus propios objetos con el mismo motor que usa la interfaz. Reciben el objeto, el destino y, opcionalmente, la duración en segundos. Como pasan por `Utils.Tween`, respetan `AlanUI.Opciones.Animaciones`: con `"ninguna"` aplican el valor al instante, y con `"fantasma"` un cambio de tamaño de un contenedor pesado también es instantáneo.

```lua
local A = AlanUI.Animaciones
A.Fade(marco, 0.5, 0.2)                          -- BackgroundTransparency hasta 0.5 en 0.2 s
A.Slide(marco, UDim2.new(0.3, 0, 0.4, 0), 0.2)   -- Position hasta ese valor
A.Scale(marco, UDim2.new(0, 50, 0, 40), 0.2)     -- Size hasta ese valor
A.Bounce(marco, UDim2.new(0, 80, 0, 60))         -- se agranda un poco y vuelve a ese tamaño
```


#### 🔑 API rápida de Flags (`ObtenerFlag`, `Try`, `ObtenerElemento`)
Tres formas de leer el valor actual de un control desde tu propio código, sin depender de que el `Callback` se haya disparado:

```lua
AlanUI:ObtenerFlag("velocidad")        -- valor actual, o nil si el flag no existe
AlanUI:Try("velocidad", 16)            -- igual, pero devuelve 16 (el fallback) si es nil
AlanUI:ObtenerElemento("velocidad")    -- el control completo: { Set(valor), Get() }
```

`Try` es útil especialmente para controles sin `Callback` (un patrón válido en AlanUI: crear el control solo para guardar el flag, y leerlo cuando haga falta en vez de reaccionar a cada cambio).

#### 🔌 `AlanUI:DesconectarYLimpiar(conexion)`
Desconecta una conexión de Roblox (`RBXScriptConnection`) y la saca del registro interno de limpieza en un solo paso. Solo hace falta si tu propio script registra conexiones manualmente con `AlanUI:RegistrarConexion()` y necesita desconectar alguna antes de que la ventana se destruya (por ejemplo, un listener temporal) — para el resto de los casos, la limpieza automática al destruir la ventana ya se encarga.

```lua
local conexion = AlanUI:RegistrarConexion(workspace.ChildAdded:Connect(function() end))
-- ... mas tarde, si ya no hace falta:
AlanUI:DesconectarYLimpiar(conexion)
```

#### 🩺 Profiler bajo demanda (`AlanUI:Profiler()`)
Devuelve una foto instantánea del estado interno de la librería — Flags, Elementos, conexiones, hilos, dibujos, objetos de GUI y memoria aproximada — y además la imprime en consola en una sola línea. Complementa al panel de Salud de la pestaña Preinstalada: ese corre en vivo mientras la pestaña está abierta, esto lo puedes pedir en cualquier momento desde tu propio código.

```lua
local datos = AlanUI:Profiler()
print(datos.Conexiones, datos.ObjetosGui)
```

> 🆕 **v2.13.2:** `Profiler()` también devuelve `MemoriaLuaMb` (el heap de Lua, aparte de `MemoriaMb`, que es la del cliente completo) e `InstanciasUI` (las instancias de UI vivas que cuenta la librería). Los dos aparecen en el reporte de `DiagnosticoCompleto(true)`.


**`AlanUI:Profiler(true)` (v2.12.6)** además **compara** con la última vez que lo llamaste y agrega el campo `Comparacion`. La primera llamada solo guarda la línea base.

```lua
AlanUI:Profiler(true)               -- línea base
-- ...usas tu script un rato...
local c = AlanUI:Profiler(true).Comparacion
print(c.Detalle)                    --> "Sin crecimiento desde la lectura anterior."
```

| Campo de `Comparacion` | Qué es |
|---|---|
| `PrimeraLectura` | `true` si no había lectura anterior (solo se guardó la base). |
| `HayCrecimiento` | `true` si algún contador creció. **Es una señal para mirar, no un veredicto**: crear controles a propósito también hace crecer los contadores. |
| `Deltas` | Diferencia por contador: `Conexiones`, `Hilos`, `Dibujos`, `Instancias`, `ObjetosGui`. |
| `DeltaMemoriaMb` | Cambio de memoria aproximada (informativo; no cuenta para `HayCrecimiento`). |
| `GlobalesDisponibles` | `true` si el ejecutor tiene `getconnections`. Si es `false`, "sin crecimiento" habla solo del registro interno de la librería, no de las conexiones del motor. |
| `DeltasGlobales` | Solo con `getconnections`: diferencia de conexiones vivas en `InputBegan`, `InputChanged`, `InputEnded`, `Heartbeat` y `RenderStepped`. Detecta listeners que se quedaron sin liberar. |
| `Muertas` | `{ Conexiones, Hilos }`: entradas del registro que ya estaban desconectadas o terminadas. |
| `Detalle` | Resumen en una línea. |

#### 📋 `AlanUI:DiagnosticoCompleto()`
Devuelve una tabla con el estado del entorno: `Tipo`, `Plataforma`, `EsStudio`, `Ejecutor`, `Viewport`, `Forzado`, `FeaturesOk`, `FeaturesTotal`, `Advertencias` y `Capacidades`.

**`AlanUI:DiagnosticoCompleto(true)` (v2.12.6)** además arma un **reporte de texto** pensado para pegar en un reporte de bug, y lo copia al portapapeles. Incluye versión y build, modo (Mini o completo), ejecutor, entorno, viewport, funciones soportadas con sus advertencias, **todas las `AlanUI.Opciones` activas**, una foto del `Profiler` y los últimos 5 errores. Devuelve la misma tabla de siempre más `Reporte` (el texto) y `Copiado` (`true` si se pudo copiar). Si el ejecutor no tiene `setclipboard`, el reporte se imprime en consola. Sin el `true` no cambia nada.


#### 💾 SaveManager — `SM:Listar()`
Devuelve la lista de nombres de configuraciones guardadas (archivos `.json` dentro de la carpeta de AlanUI). Útil si quieres, por ejemplo, un Dropdown para que el usuario elija entre varios perfiles guardados.

> ⚠️ Depende de `AlanUI.Capacidades.Archivos`. En un ejecutor sin soporte de archivos, devuelve una tabla vacía (`{}`) en vez de dar error.

```lua
local perfiles = AlanUI.SaveManager:Listar()
-- perfiles --> { "AlanUI_Settings", "perfil_combate", "perfil_farmeo" }

SeccionAjustes:Dropdown({
    Texto = "Cargar perfil",
    Opciones = perfiles,
    Callback = function(nombre)
        AlanUI.SaveManager:Cargar(nombre)
    end
})
```

#### 💾 SaveManager — `SM:CambiarPerfil(ventana, nombre)`
Cambia el "perfil" activo de una ventana en una sola llamada: guarda el perfil actual, apunta el autoguardado nativo y `GuardarConfiguracion`/`CargarConfiguracion` al nombre nuevo, y carga ese archivo si ya existe. Útil para varios sets de ajustes completos ("Farm", "PvP", "Raid") que el usuario cambia con un botón o Dropdown.

> Esta función es de conveniencia — la infraestructura de archivos con nombre ya existía antes (`SM:Guardar("Farm")` / `SM:Cargar("PvP")` siempre funcionaron). Lo nuevo es que además redirige el autoguardado y las funciones de la ventana al nombre activo.

```lua
SeccionPerfiles:Dropdown({
    Texto = "Perfil activo",
    Opciones = {"Farm", "PvP", "Raid"},
    Callback = function(nombre)
        AlanUI.SaveManager:CambiarPerfil(Ventana, nombre)
    end
})
```

#### 🎨 ThemeManager — `TM:AgregarTema(nombre, tabla)`
Registra un tema propio (colores personalizados) para que aparezca junto a los temas nativos en el selector de temas.

Un tema completo tiene **14 claves base** (más 4 colores de estado opcionales, ver abajo). Estas son las reales (ojo: la clave del color de fondo principal es `Background`, no `Fondo`):

```lua
AlanUI.ThemeManager:AgregarTema("MiTemaAzul", {
    Background      = Color3.fromRGB(45, 60, 90),   -- color de fondo general de la ventana
    BackgroundDark  = Color3.fromRGB(30, 42, 68),    -- variante mas oscura (bordes, sombreados)
    BackgroundLight = Color3.fromRGB(60, 78, 112),   -- variante mas clara (resaltados)
    Accent          = Color3.fromRGB(60, 120, 255),  -- color de acento (toggles activos, barra de tabs)
    AccentLight     = Color3.fromRGB(110, 160, 255), -- variante clara del acento (hover sobre acento)
    Highlight       = Color3.fromRGB(160, 195, 255), -- resaltado adicional (texto sobre acento, etc.)
    Text            = Color3.fromRGB(230, 230, 240), -- color de texto principal
    TextDark        = Color3.fromRGB(200, 200, 215), -- texto secundario/atenuado
    Border          = Color3.fromRGB(15, 20, 35),    -- bordes de ventana y controles
    Panel           = Color3.fromRGB(25, 30, 50),    -- fondo de la ventana principal
    PanelClaro      = Color3.fromRGB(35, 42, 68),    -- variante clara de Panel (paneles internos)
    Fila            = Color3.fromRGB(30, 36, 58),    -- fondo de cada fila de control (Toggle, Slider, etc.)
    Entrada         = Color3.fromRGB(20, 25, 42),    -- fondo de campos de entrada (Input, barra de Slider)
    Apagado         = Color3.fromRGB(60, 60, 60),    -- color de elementos deshabilitados
})

-- Ya lo puedes aplicar como cualquier otro:
Ventana:CambiarTema("MiTemaAzul")
```

> ⚠️ **Un tema parcial (con menos de las 14 claves base) NO resetea las que faltan.** `AgregarTema`/`CambiarTema` solo sobreescriben las claves que efectivamente pasaste — las que no incluiste se quedan con el valor que tenía el **tema anterior**, no con ningún default. Si tu tema personalizado solo define `Background` y `Accent`, el resto de la interfaz (`Fila`, `Entrada`, `Border`, etc.) va a seguir mostrando los colores del tema que estuviera activo antes de cambiar — puede verse como una mezcla rara de dos temas si no se cubren las 14 claves base.

> ℹ️ **Colores de estado:** `Exito`, `Aviso`, `Peligro` e `Info` son la excepción. Si tu tema no los define, recibe un juego neutro, claro u oscuro según su `Background`, en lugar de heredar los del tema anterior.

#### 🎨 `TM:AplicarTema(nombreOTabla)`
Aplica los colores de un tema registrado (por su nombre) o de una tabla de colores. Es la función que cambia los colores en vivo; el selector de temas de la Preinstalada la llama. Con un nombre que no existe no hace nada. Una tabla parcial solo sobreescribe las claves que trae (ver la advertencia de arriba).

```lua
AlanUI.ThemeManager:AplicarTema("Blanco")                                   -- un tema registrado
AlanUI.ThemeManager:AplicarTema({ Background = Color3.fromRGB(30, 30, 40) })  -- una tabla de colores
```

`AplicarTema` también acepta un **color** (v2.13.0): `AlanUI.ThemeManager:AplicarTema(Color3.fromRGB(200, 60, 90))` arma un tema oscuro con ese acento, y `AplicarTema({ Base = Color3.fromRGB(200, 60, 90), Claro = true })` uno claro. Con `Opciones.AutoContraste = true`, el texto con poco contraste pasa a blanco o negro.


#### 🎨 `TM:GuardarTemaActual()`
Guarda a disco los colores del tema activo en este momento (`tema.json`, en la carpeta de perfiles). Método de una línea, útil si quieres persistir un tema aplicado dinámicamente sin pasar por el flujo normal de `AgregarTema`.

```lua
AlanUI.ThemeManager:GuardarTemaActual()
```

#### 🔒 Bloqueo y resaltado de controles (v2.12.5+)
Cualquier control interactivo (ver la lista en el apartado `Locked` de arriba) puede bloquearse: se tapa con una capa semitransparente y una insignia "🔒 motivo", y deja de responder.

```lua
-- Nace bloqueado:
local t = SeccionCombate:Toggle({ Texto = "Modo VIP", Flag = "vip", Locked = true, LockedTitle = "Requiere VIP" })

-- O en cualquier momento:
t.Lock("Requiere nivel 20")   -- bloquea (el motivo es opcional)
t.SetLockedTitle("Nivel 30")  -- cambia el motivo en vivo
print(t.IsLocked())           --> true
t.Unlock()                    -- desbloquea

-- Resalta el control con un pulso de borde para llamar la atención:
t.Highlight(3)                -- 3 segundos (rango permitido: 0.5 a 10)
t.Highlight({ Duracion = 2 })
```

El control devuelto también expone `Fila` (el `Frame` de la fila, para tus propios ajustes). Los métodos aceptan llamada con `.` o con `:`.

#### ↩️ Historial de cambios: Deshacer / Rehacer (v2.12.5+)
Todo cambio en un control de tu script (mover un slider, tocar un toggle, elegir una opción) se registra solo en un historial de hasta **50 pasos**. No hay que configurar nada.

```lua
AlanUI:Deshacer()            -- true (y la entrada) si deshizo algo; false si no había nada
AlanUI:Rehacer()
AlanUI:PuedeDeshacer()       -- boolean
AlanUI:PuedeRehacer()        -- boolean
AlanUI:ObtenerHistorial()    -- { Deshacer = n, Rehacer = n }
AlanUI:LimpiarHistorial()    -- vacía ambas pilas

local ok, entrada = AlanUI:Deshacer()
if ok then print(AlanUI:DescribirCambio(entrada)) end --> "vel: 80 -> 50"

AlanUI.Eventos.HistorialCambiado:Connect(function(nDeshacer, nRehacer) end)
```

- Mover un mismo slider de forma continua (menos de 0.6 s entre cambios) se agrupa en **un solo paso**; varios flags que cambian a la vez (ej. cargar un perfil) también se agrupan.
- Hacer un cambio nuevo después de deshacer descarta la pila de "rehacer".
- Quedan fuera del historial: los flags de interfaz (`MarcarComoUI`) y los controles de solo lectura (`Label`, `Progreso`).
- Deshacer/Rehacer vuelven a aplicar el valor **ejecutando el `Callback`** del control, como si el usuario lo hubiera movido.
- Cargar un perfil o los ajustes de interfaz (`SM:CargarSilencioso`, `SM:CargarUI`) **limpia** el historial, para no mezclar pasos de un perfil con otro.

#### ❓ Modal de confirmación (`AlanUI:Confirmar`) (v2.12.5+)
Muestra un diálogo modal sobre la ventana, con el mismo estilo que el de la "✕". Requiere que haya una ventana de AlanUI activa (si no, avisa por consola y devuelve `nil`).

```lua
AlanUI:Confirmar({
    Icono = "⚠️",
    Titulo = "¿Resetear todo?",
    Contenido = "Se perderán los valores actuales.",
    BotonCancelar = { Texto = "Cancelar" },
    BotonAceptar  = { Texto = "Resetear", Variante = "danger", Callback = function() Ventana:Resetear() end },
})
```

- **Forma simple:** `BotonAceptar` (default "Aceptar", variante `primary`) y `BotonCancelar` (solo aparece si lo pasas).
- **Forma libre:** `Botones = { { Texto, Variante, Callback }, ... }` para tantos botones como quieras (con más de 3 se apilan en vertical).
- `Variante`: `"primary"` (acento), `"danger"` (rojo), `"tertiary"` (solo borde) o `"neutral"` (default).
- `Ancho` (240 a 480, por defecto 300) y `ColorBorde` (un `Color3`: el borde pasa a 2 px con ese color y deja de seguir al tema).
- `Casilla = { Texto = "No volver a preguntar", Defecto = false }` agrega una casilla. Su estado llega a los `Callback` de los botones: `Callback = function(marcada) ... end`.
- `Input = { Defecto = "", Placeholder = "", Area = false, Validar = function(texto) return ok, mensaje end, SoloLectura = false, Monoespaciado = false }` agrega un campo de texto (v2.12.7). El texto llega como segundo argumento del `Callback` de cada botón: `Callback = function(marcada, texto) ... end`. `Validar` se evalúa al presionar cualquier botón menos el de cancelar (`BotonCancelar`, o un botón de `Botones` con `Cancelar = true`): si devuelve `false, "mensaje"`, el modal sigue abierto y muestra el aviso. Si `Validar` falla con un error, se registra y se deja pasar.
- Cualquier botón cierra el modal antes de ejecutar su `Callback`. Devuelve `{ Cerrar(), Presionar(i), Fondo, ObtenerCasilla(), ObtenerTexto() }`.

#### 💬 `AlanUI:Dialogo(cfg)` (v2.12.5+)
Un modal que elige solo el ícono, el color del borde y el botón de aceptar según su `Tipo`. No es otra implementación: usa `AlanUI:Confirmar`.

```lua
AlanUI:Dialogo({
    Tipo = "warning",
    Titulo = "¿Borrar perfil?",
    Contenido = "Esta acción no se puede deshacer.",
    Botones = {
        { Texto = "Cancelar", Variante = "neutral", Callback = function() end },
        { Texto = "Borrar",   Variante = "danger",  Callback = function() end },
    },
})
```

| `Tipo` | Ícono | Borde | Botones por defecto |
|---|---|---|---|
| `"info"` (default) | ℹ️ | el del tema | Entendido |
| `"question"` | ❓ | el del tema | Sí + Cancelar |
| `"success"` | ✅ | verde | Genial |
| `"warning"` | ⚠️ | amarillo | Aceptar + Cancelar |
| `"error"` | ❌ | rojo | Cerrar (en rojo) |

Acepta los mismos campos que `Confirmar` (`Titulo`, `Contenido`, `Icono`, `Ancho`, `ColorBorde`, `Casilla`, `Botones`, `BotonAceptar`, `BotonCancelar`); lo que pases sobreescribe el preset. `MostrarCancelar = false` quita el "Cancelar" de `question` y `warning`. Un `Tipo` desconocido avisa por consola y usa `"info"`.

#### 🛡️ `AlanUI:CrearVentanaConSeguridad(config)` (v2.12.5+)
`CrearVentana` siempre limpia sin avisar todo lo de la ejecución anterior — ideal cuando el **mismo** script se re-ejecuta. Pero si en el mismo ejecutor cargas dos scripts **distintos** que usan AlanUI, el segundo pisaría al primero en silencio. `CrearVentanaConSeguridad` recibe la misma tabla que `CrearVentana` y, si detecta otra ventana viva, **pregunta** antes de reemplazarla.

```lua
local Ventana = AlanUI:CrearVentanaConSeguridad({ Titulo = "Mi Script", NombreConfig = "miscript" })
if not Ventana then return end -- el usuario eligió no reemplazar
```

Devuelve la ventana creada, o `nil` si el usuario eligió no reemplazar. La preferencia de "reemplazar siempre" se recuerda por script (según su `Titulo`), dentro de su propio `NombreConfig`.

El modal de detección ("Nuevo script detectado") es un `AlanUI:Dialogo` de tipo `warning`: borde amarillo, botones **No** / **Sí, reemplazar** y la casilla "No volver a preguntar por este script". Solo aparece con `CrearVentanaConSeguridad`: `CrearVentana` reemplaza siempre sin preguntar, así que volver a ejecutar el **mismo** script no muestra ningún mensaje. Si el modal se cierra por otra vía (por ejemplo, se destruye la ventana), cuenta como "No".

#### 🌈 Bordes con degradado y animación (v2.12.5+)
La ventana (y los modales) pueden llevar un borde de color liso, con degradado o animado. Acepta lo mismo que un tag y además **los colores de la interfaz**, que siguen al tema cuando lo cambias.

```lua
Ventana:EstablecerBorde("tema")                       -- degradado con los colores del tema
Ventana:EstablecerBorde({ Color = "tema", Animar = true, Grosor = 3 })
Ventana:EstablecerBorde({ Color = { "Accent", Color3.fromRGB(255, 90, 140), "AccentLight" }, Animar = true })
Ventana:EstablecerBorde(nil)                          -- vuelve al borde de siempre

AlanUI:CrearVentana({ Titulo = "Mi Script", Borde = "rainbow" })   -- o al crearla
AlanUI:Dialogo({ Tipo = "info", Titulo = "Hola", Borde = { Color = { "Accent", "AccentLight" }, Animar = true } })
```

| Valor | Resultado |
|---|---|
| `nil` / `false` / `"ninguno"` | El borde de siempre. |
| `"tema"` | Degradado `Accent` → `AccentLight`. Sigue al tema. |
| `"acento"` | Color liso `Accent`. Sigue al tema. |
| `"borde"` | El color de borde del tema. |
| `"rainbow"` | Arcoíris. Se anima solo (salvo `Animar = false`). |
| `"info"`, `"success"`, `"warning"`, `"danger"`, `"neutral"` | Los colores del tag. |
| `Color3` | Color liso. |
| `{ c1, c2, ... }` | Degradado de 2 o más. Cada `c` es un `Color3`, una clave del tema (`"Accent"`, `"AccentLight"`, `"Highlight"`...) o un color del tag. Las claves del tema siguen al tema. |
| `{ Color = ..., Grosor = 2, Animar = true, Velocidad = 4, Transparencia = 0 }` | Tabla de configuración: `Color` es cualquiera de las formas de arriba. |

- `Animar = true` hace girar el degradado (`Velocidad` = segundos por vuelta, por defecto 4). El degradado se cierra sobre sí mismo al animarse, para que la vuelta no tenga costura. Cada borde animado usa un solo tween en bucle, que se cancela al destruir la ventana.
- `Grosor` va de 1 a 8 px (por defecto 2).
- Reutiliza el borde que ya tenga el marco (no se pueden apilar dos bordes) y al quitarlo lo deja como estaba.
- **Preinstalada** (Apariencia): selector "🌈 Borde de la ventana" (Normal, Tema, Acento, Arcoíris, Personalizado), "✨ Animar el borde", "Grosor del borde" y dos colores para el estilo Personalizado. Se guardan con el botón "Guardar" de la Preinstalada.
- Un valor de color no reconocido avisa por consola y deja el borde normal.

#### ⚙️ `AlanUI.Opciones` (v2.12.5+)
Interruptores globales: cambian el comportamiento de toda la librería sin pasar lo mismo control por control. Todos conservan el comportamiento de siempre por defecto.

**Apariencia**

| Opción | Por defecto | Qué hace |
|---|---|---|
| `ColorPickerEstiloPredeterminado` | `"RGB"` | Estilo de los `ColorPicker` sin `Estilo` propio: `"RGB"` o `"2D"`. Afecta a los que se creen después. |
| `EscalaInterfazPredeterminada` | `125` | Tamaño inicial de la interfaz, en % (70 a 130). Es lo que se aplica al abrir si no hay ajustes guardados. |
| `EscalaTextoPredeterminada` | `150` | Tamaño inicial del texto, en % (80 a 150). |
| `BordeVentanaPredeterminado` | `nil` | Borde de las ventanas que no pasan `Borde` propio (mismo formato que `CrearVentana({ Borde = ... })`). |
| `BordeAdaptativo` | `false` | Ajusta la transparencia de los bordes del tema según la luminosidad del fondo: más opacos en temas claros, más sutiles en oscuros. Se aplica en el próximo cambio de tema. |
| `EstiloVisual` | `"clasico"` | (v2.12.6) `"clasico"` o `"moderno"`: aspecto de las ventanas que se creen después. Solo cambia lo visual. Se puede elegir por ventana con `CrearVentana({ EstiloVisual = ... })`. |
| `IconosPropios` | `false` | Usa los iconos de `AlanUI.Iconos` (referenciables como `"@exito"`) en lugar de emojis en la Preinstalada y en los `Dialogo()` por tipo. |
| `TextoFijo` | `false` | Los textos con `Truncar` (nombres de pestaña, valores de las filas) mantienen su tamaño y se cortan con «…» si no caben, en vez de encogerse. Se lee al crear los controles: asignarla antes de `CrearVentana`. |
| `MicroInteracciones` | `false` | La flecha del `Dropdown` y la muestra del `ColorPicker` reaccionan junto con el hover de la fila. |
| `TransparenciaEnControles` | `false` | (v2.12.8) Con `true`, la transparencia de la ventana se extiende, más suave (60 % del valor), a las filas de los controles y a las barras de los sliders, también a los que se creen después. Con `false`, solo el fondo, la barra de título y la barra lateral. |
| `PrecargarIconos` | `true` | (v2.12.8) Pide los iconos al motor en segundo plano justo después de crearse, para que no aparezcan tarde al bajar rápido. Con `false`, el motor los descarga al dibujarlos por primera vez. |
| `Animaciones` | `"fantasma"` | (v2.13.0) Cuánto se anima la interfaz. `"fantasma"`: la ventana se minimiza animando un marco liviano y los cambios de tamaño de contenedores pesados (más de 80 descendientes) son instantáneos; `"tamano"`: se anima todo, incluido el tamaño de la ventana real; `"ninguna"`: nada se anima (ni los bordes que giran). |
| `AnimacionVentana` | `"auto"` | Modo de animación solo de minimizar y mostrar la ventana. `"auto"` sigue a `Animaciones`; `"fantasma"`, `"tamano"` o `"ninguna"` lo fuerzan. |
| `AutoContraste` | `false` | (v2.13.0) Con `true`, al aplicar un tema, el texto que no llegue a contraste 4.5:1 con los fondos pasa a blanco o negro. |
| `IndicadorGuardado` | `false` | (v2.13.0) Con `true`, un puntito en la barra de título muestra el estado del autoguardado: gris, ámbar (pendiente) o verde (recién guardado). |

**Ventana e interacción**

| Opción | Por defecto | Qué hace |
|---|---|---|
| `GuardarPosicionVentana` | `true` | Recordar la posición de la ventana entre ejecuciones. Se puede sobreescribir por ventana con `GuardarPosicion`. |
| `ConfirmarCierre` | `true` | Mostrar el modal "¿Eliminar interfaz?" al presionar la ✕. Con `false`, la ✕ destruye la ventana directo. |
| `ClickDirectoEnBarras` | `true` | Con mouse, un click en la barra de un `Slider` o `RangeSlider` coloca la manija ahí y empieza a arrastrar. Con `false` hay que mover el cursor unos píxeles. El toque (touch) siempre espera el gesto para no pelear con el scroll. |
| `AtajosHistorial` | `true` | `Ctrl+Z` deshace y `Ctrl+Y` (o `Ctrl+Shift+Z`) rehace el último cambio de un control, con una notificación breve. No actúa mientras se escribe en un campo de texto. |
| `Atajos` | tabla | Combinaciones de teclas de la ventana, solo teclado: `Ocultar = "RightShift+H"`, `Resetear = "RightShift+R"`, `Reejecutar = "RightShift+L"`, `Cerrar = "RightShift+Q"`. Formato `"Modificador+Tecla"` (`Ctrl`, `Shift`, `Alt` o `RightShift`, `LeftControl`...). `false` en una acción la apaga. |

**Desarrollo**

| Opción | Por defecto | Qué hace |
|---|---|---|
| `ModoDev` | `false` | (v2.12.6) Avisa por consola de claves desconocidas al crear cada control, con sugerencia, y de opciones de esta tabla que no existen (por ejemplo `EstiloVisul`). `AlanUI.DebugMode = true` también lo activa. Los avisos quedan en `AlanUI:ObtenerErrores("aviso")`. |

**Notificaciones**

| Opción | Por defecto | Qué hace |
|---|---|---|
| `MaxColaNotificaciones` | `50` | (v2.12.6) Tope de la cola de notificaciones en espera. `0` = sin tope. |

```lua
AlanUI.Opciones.ConfirmarCierre = false
AlanUI.Opciones.ColorPickerEstiloPredeterminado = "2D"
AlanUI.Opciones.ModoDev = true   -- mientras desarrollas tu script
```


#### 💾 SaveManager — `SM:Duplicar` / `SM:Renombrar` / `SM:Exportar` / `SM:Importar` (v2.12.5+)
Operaciones sobre los perfiles de script guardados. Todas devuelven `true`/`false` (o texto) más un mensaje de motivo si algo falla, y requieren `AlanUI.Capacidades.Archivos`.

```lua
local SM = AlanUI.SaveManager
SM:Duplicar("Farm", "Farm_copia")        --> true  | false, "Ya existe un perfil con ese nombre"
SM:Renombrar("Farm_copia", "Farm_v2")    --> true
local texto, copiado = SM:Exportar("Farm_v2") -- texto del perfil; 'copiado' = true si se pudo enviar al portapapeles
SM:Importar("Farm_importado", texto)     --> true | false, motivo   (3er parámetro: true para sobreescribir)
```

- Los nombres de perfil son válidos si tienen entre 1 y 60 caracteres y no incluyen `/ \ : * ? " < > |` ni caracteres de control.
- `Importar` valida que el texto sea un JSON válido y tenga como máximo 200000 caracteres; no sobreescribe un perfil existente salvo que pases `true`.
- La sección "Perfiles de script" de la pestaña Preinstalada ya incluye botones de Duplicar, Renombrar, Exportar e Importar.

#### 🧹 Destrucción completa (Destruir)
Cierra la interfaz y hace la limpieza completa: desconecta las conexiones registradas, cancela los hilos, quita los `Drawing` y las instancias registradas, y suelta las conexiones globales de la librería (tamaño de pantalla, arrastre y actualización de `Label`), liberando la memoria por completo. También vacía los registros internos de la librería (tema, buscador, escala de texto, elementos), dejando todo listo por si tu script crea otra ventana después — en ese caso las conexiones globales se vuelven a enganchar solas. Es instantánea — no muestra ningún diálogo de confirmación (esa confirmación solo aparece cuando el usuario final toca la "✕" de la ventana, no cuando tu código llama a esta función). Es segura de llamar más de una vez, y llamarla sobre una ventana vieja no afecta a una ventana nueva que ya exista.

```lua
Ventana:Destruir()
```

---

## 📜 Historial de versiones anteriores

Las versiones anteriores a la 2.12.6, de la más reciente a la más antigua. Siguen siendo válidas para quien trabaje con una versión vieja de la librería; lo que cambió después está en [Novedades v2.13.3](#-novedades-v2133), [Novedades v2.13.2](#-novedades-v2132), [Novedades v2.13.1](#-novedades-v2131), [Novedades v2.13.0](#-novedades-v2130), [Novedades v2.12.9](#-novedades-v2129), [Novedades v2.12.8](#-novedades-v2128) y [Novedades v2.12.7](#-novedades-v2127).

## 🆕 Novedades v2.12.5

Ronda de nuevas capacidades de la API. El código de la librería ya las incluía, pero faltaban en este README — ahora están documentadas con sus campos reales (verificados contra el código):

- **Tres controles nuevos:** [`RangeSlider`](#14-rangeslider-slider-de-rango) (rango mínimo-máximo con dos manijas), [`NumberStepper`](#16-numberstepper-contador-numérico) (botones − / + con campo editable) y [`TagInput`](#15-taginput-lista-de-etiquetas) (lista de etiquetas tipo "chips").
- **Dos elementos de layout nuevos:** `Seccion:Imagen` (imagen con relación de aspecto) y `Seccion:Grupo` (varios botones en una misma fila, que pasan a vertical solos si no hay ancho).
- **Construcción por tablas:** `Seccion:Construir(lista)` y `Ventana:ConstruirDesdeSchema(schema)` arman controles, secciones y pestañas enteras desde datos, sin escribir una llamada por control.
- **Historial de cambios (Deshacer / Rehacer):** `AlanUI:Deshacer()`, `AlanUI:Rehacer()` y funciones de consulta. Es automático — registra cualquier cambio de control (50 pasos máximo). La pestaña Preinstalada trae una sección con los botones listos.
- **Modal `AlanUI:Confirmar(cfg)`:** diálogo de confirmación con botones personalizables, del mismo estilo que el de la "✕".
- **Bloqueo y resaltado de controles:** todo control interactivo acepta `Locked`/`LockedTitle` y expone `Lock`, `Unlock`, `IsLocked`, `SetLockedTitle` y `Highlight`.
- **Tags en la barra de título:** `Ventana:AgregarTag(cfg)` agrega pastillas de color (ej. "BETA", "v1.2") al lado del título, con soporte de degradado y arcoíris animado.
- **Nuevas funciones de ventana:** `Minimizar`, `Mostrar`, `EstaVisible`, `Resetear`, `AgregarDivisorSidebar` y `Tab:CrearDivisor`.
- **`AlanUI:CrearVentanaConSeguridad(config)`:** como `CrearVentana`, pero pregunta antes de reemplazar una ventana de **otro** script que ya esté abierta.
- **Más control de perfiles en `SaveManager`:** `Duplicar`, `Renombrar`, `Exportar` (copia el perfil como texto al portapapeles) e `Importar` (desde texto). La sección "Perfiles de script" de la Preinstalada ya trae los botones.
- **Campos extra en controles existentes:** `Boton` (`Interact`), `Label` y `Parrafo` (`Descripcion`), `Parrafo` (imagen, miniatura y botones propios), `Dropdown` (opciones con descripción, ícono, bloqueo y separadores), `CrearTab` (ícono por asset y color de ícono) y `CrearVentana` (`Orientacion`).
- **Nuevos eventos:** `AlanUI.Eventos.TipoCambiado` y `AlanUI.Eventos.HistorialCambiado`.
- **`Keybind` con modos:** `Modo = "Press"` (default), `"Hold"` (`true` al presionar, `false` al soltar) o `"Toggle"` (alterna `true`/`false`). Ver [Keybind](#5-keybind-tecla-asignable).
- **`AlanUI:Dialogo` y `Confirmar` ampliado:** un modal que elige ícono, borde y botón según el `Tipo` (`info`, `question`, `success`, `warning`, `error`). `Confirmar` acepta ahora `Ancho`, `ColorBorde` y `Casilla`.
- **Mensaje "Nuevo script detectado" rediseñado:** usa el mismo modal que el resto, con borde amarillo y los botones y la casilla "No volver a preguntar" **visibles**. Antes se veían solo sus textos: estaban hechos con `Utils.BotonBase` sin indicar `Transparencia`, y `BotonBase` es transparente por defecto.
- **Posición de la ventana recordada:** `GuardarPosicion` (default `true`), `PosicionInicial` y `Ventana:ResetearPosicion` / `GuardarPosicion` / `CargarPosicion`. La Preinstalada trae un toggle y un botón.
- **`Seccion:Columnas`:** divide una sección en dos columnas que se apilan solas si no caben.
- **`ColorPicker` con `Estilo = "2D"`:** cuadrado de saturación/valor y barra de matiz. Es opcional; por defecto sigue el estilo `"RGB"`.
- **`AlanUI.Opciones`:** `ColorPickerEstiloPredeterminado`, `GuardarPosicionVentana`, `ConfirmarCierre`, `EscalaInterfazPredeterminada`, `EscalaTextoPredeterminada` y `BordeVentanaPredeterminado`.
- **Tamaño inicial real (más grande):** los sliders "Tamaño de la interfaz" y "Tamaño del texto" **mostraban** 125 % y 150 %, pero la interfaz arrancaba al 100 % (el `Slider` no ejecuta su `Callback` al crearse, así que nada aplicaba esos valores). Ahora se aplican de verdad al abrir: el texto arranca más grande. Se cambian con `AlanUI.Opciones.EscalaInterfazPredeterminada` y `EscalaTextoPredeterminada` (en %), y los ajustes guardados siguen mandando.
- **Una ventana nueva ya no hereda el tamaño de texto de la anterior:** ese factor es del módulo y no se reiniciaba, así que la segunda ventana de un script podía nacer con el texto que había dejado la primera.
- **Bordes con degradado y animación:** `CrearVentana({ Borde = ... })`, `Ventana:EstablecerBorde(...)` y `Borde` en los modales. Aceptan lo mismo que un tag y además los **colores del tema**. Ver [Bordes con degradado y animación](#-bordes-con-degradado-y-animación-v2125). La Preinstalada trae su selector.
- **Pestaña activa:** además de la barrita, lleva un tinte de acento muy suave. Y se corrigió un bug: al alternar la orientación, la pestaña activa se pintaba con el color de acento y quedaba así al cambiar de pestaña.
- **Slider con manija:** un círculo al final del relleno muestra dónde está el valor (`Manija = false` lo quita).
- **Anillo de foco:** los campos de texto (`Input`, `NumberStepper`, `TagInput`, hex del `ColorPicker`, buscadores y el valor del `Slider`) muestran un borde de acento mientras escribes.
- **Notificaciones:** la franja de acento se va consumiendo durante la duración de la notificación.
- **Íconos del header dibujados:** la ✕ y el "—" ya no son texto/emoji (cambiaban según la fuente del ejecutor) sino barras dibujadas.
- **Buscador con "Sin resultados":** si nada coincide, aparece un cartel en vez de una página en blanco.
- **Preinstalada más liviana:** FPS, frametime, memoria y salud solo se escriben cuando la pestaña y la ventana están visibles. El contador de frames y la referencia de salud (a los 5 s) siguen corriendo siempre.

> ℹ️ Las secciones de referencia de cada una están más abajo, en "Referencia de la API". Para la lista completa de campos, mira esas secciones — esta lista es solo el resumen.

## 🎬 Animaciones: revisión de consistencia (v2.12.5)

- **Feedback directo sin tween:** lo que responde al dedo o cursor mientras se arrastra (relleno de los sliders, tamaño y escala de la ventana desde la pestaña Preinstalada, y el número del TextBox) ya no se anima: sigue el movimiento al instante. Lo que cambia por código (carga de perfil, `Set()`) sí se anima.
- **Las duraciones de las animaciones de la interfaz salen de `AlanUI.Motion`.** `Motion.Directo = 0` aplica el cambio sin tween. Quedan fijos a propósito algunos efectos decorativos o continuos (el pulso de `Highlight`, el giro del arcoíris de las tags, la sacudida del bloqueo) y los temporizadores de interacción (pulsación larga, autorepetición del `NumberStepper`).
- **Curvas con sentido:** `EaseEntrar` (Quart Out) para lo que entra, `EaseSalir` (Quad In) para lo que sale, `EasePop` para rebotes. Antes `EaseSalir` era igual a `EaseEntrar`.
- **Pestañas y botones de ventana con el mismo click que el resto:** ya no usan `MouseButton1Click` directo; se benefician del umbral anti-scroll y del pop al tocar.
- **Entradas y salidas visibles:** las pastillas de `AgregarTag` y los chips de `TagInput` entran con pop; los chips salen encogiéndose; la flecha de las secciones y paneles gira animada.
- **Arreglo:** la propiedad de la sombra de la ventana era incorrecta (`Transparencia` en vez de `BackgroundTransparency`), por eso su fade-in nunca se ejecutaba.
- **Arreglo:** el contador numérico de un `Slider` con decimales mostraba valores incorrectos al animar (ej. "0" en vez de "0.3"). Ahora usa los decimales del `Incremento`.
- **Ventana más rápida:** cierre 0.18s, restauración 0.25s, y la barra de carga del splash tiene un tope de 1.0s (antes podía llegar a 2.2s con muchos controles).
- **Bloqueo animado:** `Lock()` ahora desvanece el velo y desliza la insignia "🔒 motivo" con rebote; `Unlock()` lo desvanece. `IsLocked()` y `Visible` del velo siguen cambiando al instante. Un control que nace con `Locked = true` queda directo, sin animación.
- **Tocar un control bloqueado:** la insignia se sacude (±3px, 0.25s) y destella en rojo, para indicar que no se puede usar.
- **Notificación persistente:** al tocarla da feedback (pop + borde encendido) antes de cerrarse. Si se toca mientras entra, se cierra directo.
- **Splash:** el panel de fondo ahora también entra con fade (antes aparecía opaco de golpe y solo se animaban sus textos).
- **Pestañas y divisores de la barra lateral:** entran con fade, pero **solo si se crean cuando la ventana ya es visible**. Las que se crean durante el armado inicial quedan tapadas por el splash y no se animan.
- **Arreglo (Dropdown / ColorPicker):** el panel ya no se cierra al empezar un scroll con el dedo fuera de él. Ahora cierra solo con un tap real (mismo umbral anti-scroll que `ClickConfiable`: 18px en touch, 10px con mouse). Con mouse, cierra al soltar el click y no al presionarlo.
- **Arreglo (memoria):** las notificaciones, los chips de `TagInput` y los diálogos que se destruían en plena ejecución dejaban su entrada en los registros internos de tema y de escala de texto, y no se liberaba nunca. Ahora cada entrada se marca al destruirse la instancia y los registros se compactan en lote.
- **Cambio de orientación animado:** al alternar entre tabs laterales y barra superior, la barra que aparece entra deslizándose con un fade (antes el cambio era instantáneo).
- **Cambio de tema animado:** los colores hacen una transición suave en vez de saltar. Solo se animan los elementos visibles; lo que está en pestañas ocultas cambia directo, para no animar cientos de instancias que nadie ve. Durante el armado inicial y al restaurar el tema guardado bajo el splash se aplica directo.
- **Divisores animados:** `Ventana:AgregarDivisorSidebar` y `Tab:CrearDivisor` crecen desde cero con un fade cuando se crean con la ventana ya visible.
- **Arreglo (tooltip por mantener presionado):** reforzado en touch. Usa el mismo umbral que `ClickConfiable` (18px en touch; antes 10px, demasiado estricto para un dedo), vigila el toque cada 50 ms en vez de mirarlo una sola vez al final y agrega el evento `TouchLongPress` como segundo disparador. No pude reproducirlo sin Roblox: es un refuerzo basado en el código, no una causa confirmada.

## 🆕 Novedades v2.12.4 (patch)

Ronda de mejoras visuales y de feedback, pensada para que la interfaz avise mejor cuándo una acción se registró:

- **Secciones colapsables más claras y animadas:** el header entero ahora responde con un hover sutil al tocarlo/pasarle el cursor (antes solo la flecha sugería que era interactivo), y colapsar/expandir ahora anima la altura en vez de ocultarse de golpe. Las transiciones que dispara el buscador (expandir todo al buscar, restaurar al limpiar) siguen siendo instantáneas a propósito — animar muchas secciones a la vez con la búsqueda se sentiría lento.
- **Sliders con más brillo:** el degradado de la barra de relleno (ya existía, pero era muy sutil) ahora tiene más intensidad en `Slider` y en los canales R/G/B de `ColorPicker`.
- **Flash de validación (verde/rojo) en 3 controles:** `Slider` (TextBox de valor), `Input` con `Tipo = "number"` o `Tipo = "pattern"`, y el campo Hex de `ColorPicker`. Antes, escribir un valor inválido y presionar Enter revertía en silencio, sin ninguna señal de que pasó algo — ahora un flash rojo confirma que se rechazó, uno verde confirma que se aceptó.

## 🆕 Novedades v2.12.3 (patch)

- **El texto ya no se corta tan fácil:** los controles con texto de una sola línea en un espacio fijo (el nombre de cualquier control, valores de `Label`, etc.) ahora achican la letra automáticamente lo necesario para entrar completos, antes de recurrir al corte con "…" como último recurso. Se recalcula solo al redimensionar la ventana, mover el slider de escala de texto, o cambiar el texto de un control en vivo.
- **Avisos de la Preinstalada, legibles del todo:** los mensajes de "Advertencias del sistema" (ProtectGUI, Teclado, Gamepad) ya no se cortan a mitad de oración — ahora se muestran completos, en varias líneas si hace falta.
- **`RadioGroup` ya no se "quema" en blanco en mobile:** mantener el dedo presionado o tocar varias veces seguidas sobre un control ya no acumula el efecto de brillo de hover hasta blanco puro. Afecta a la mayoría de los controles de la librería, no solo `RadioGroup`.
- **Los sliders ya no roban el scroll en mobile:** antes, si el dedo pasaba sobre un `Slider` (o los canales de `ColorPicker`) mientras se intentaba scrollear la página, el slider se movía en vez de dejar scrollear. Ahora se espera a que el gesto se defina por su dirección dominante (horizontal = arrastre, vertical = scroll) antes de reaccionar. Cambio de comportamiento: un toque corto sin arrastre ya no mueve el valor del slider al punto tocado — antes sí lo hacía, y era justamente lo que causaba este bug.

## 🆕 Novedades v2.12.2 (patch)

`Seccion:Label` gana cuatro capacidades nuevas, pensadas para casos como mostrar FPS, la tecla detectada, o el estado de un script en vivo:

- **`RichText` en el valor dinámico:** hasta ahora `RichText` solo aplicaba al título del Label; ahora también se puede pasar para el valor que cambia con `Set()`, permitiendo tags como `<font color='#00FF00'>OK</font>` directamente en el texto.
- **`SetColor(color)`:** cambia el color del valor mostrado puntualmente (ej. verde para "OK", rojo para "Error"), sin tocar el color del título. El color elegido se mantiene aunque el usuario cambie de tema después — antes de este fix, un cambio de tema hubiera pisado silenciosamente cualquier color personalizado.
- **`SetTexto(texto)`:** alias de `Set()`, para cuando el nombre "Set" resulta ambiguo al lado de "SetColor".
- **Auto-actualización opcional con `Cada` + `Actualizar`:** pasando `Cada = 0.5` (segundos) y una función `Actualizar` que devuelve el nuevo valor, el Label se refresca solo — sin que el desarrollador tenga que armar su propio loop. Internamente, **todos** los Labels con auto-actualización de una ventana comparten un único loop global (no uno por Label), así que crear varios no cuesta hilos extra.
- **`AlanUI:ActualizarLabel(flag, texto)`:** atajo para actualizar un Label por su `Flag` sin tener que guardar la referencia devuelta por `Seccion:Label(...)`.

```lua
-- Con RichText
local lbl = Seccion:Label({ Texto = "Estado", Flag = "st", Valor = "–", RichText = true })
lbl:Set("<font color='#00FF00'>OK</font>")

-- Con color dinámico
local lbl = Seccion:Label({ Texto = "Ping", Flag = "ping", Valor = "–" })
lbl:Set("25ms")
lbl:SetColor(Color3.fromRGB(0, 255, 0)) -- verde = bien

-- Con auto-update (cada 0.5s)
Seccion:Label({
    Texto = "FPS", Flag = "fps", Valor = "–",
    Cada = 0.5,
    Actualizar = function() return tostring(math.floor(workspace:GetRealPhysicsFPS())) end,
})

-- Helper global, sin guardar la referencia del Label
AlanUI:ActualizarLabel("ping", "30ms")
```

## 🆕 Novedades v2.12.1 (patch)

Ronda de correcciones de fragilidad y accesibilidad táctil, encontrada en una auditoría de código + retest en dispositivo real (Android, ejecutor Delta):

- **Guards de tipo en los 11 controles con `Set` público** (`Slider, Input, Dropdown, ColorPicker, Keybind, RadioGroup, Toggle, Casilla, Progreso, Label, Parrafo`): si se les pasa un valor del tipo equivocado, ahora avisan por consola (`AlanUI:_RegistrarError`) y ese `Set` puntual se ignora, en vez de romper el script del desarrollador con un error críptico como `invalid argument #1 to 'clamp'`.
- **`:Set(v)` y `.Set(v)` ahora funcionan igual (cambio de comportamiento):** antes, llamar a un `Set` público con dos puntos (`control:Set(50)`, un error de sintaxis muy común en Lua) pasaba por accidente la propia tabla del control como valor, en vez del `50` real — normalmente terminaba en un crash. Ahora ambas formas de llamada se normalizan y funcionan igual. Esto es aditivo y no debería romper ningún script existente que ya llamara con `.Set(v)` correctamente.
- **Umbral de `ClickConfiable` dinámico según dispositivo:** 18px en touch, 10px en mouse (antes, 10px fijo para los dos). Un tap normal en celular se desvía 15-20px entre el toque y la soltada sin que el usuario lo perciba como un scroll; con el umbral viejo, ese movimiento normal se descartaba como "fue scroll" y el click no se registraba.
- **Hitboxes ampliados en 6 controles:** `Toggle`, `Casilla`, `RadioGroup`, opciones de `Dropdown`, swatches de `ColorPicker`, y los botones de tab (barra lateral y horizontal) ahora responden al toque en un área más grande que su tamaño visual, sin ningún cambio de aspecto — más generoso en controles aislados (`Toggle`/`Casilla`, +20px de diámetro) y más conservador en controles que viven pegados a un vecino en una lista (`RadioGroup`, swatches y tabs, +14px; `Dropdown`, +12px, el más ajustado porque sus opciones tienen apenas 2px de separación entre sí). En mobile, esto se siente como si los controles fueran más grandes de lo que en realidad son.
- **Corrección visual en `RadioGroup` en mobile:** la opción elegida podía perder su resaltado azul justo después de tocarla (un problema de `Utils.Hover` restaurando un color viejo al soltar el dedo, no algo relacionado al valor guardado). En PC no se notaba porque el mouse no dispara el mismo evento al hacer click.
- **Heurística Tablet vs. Móvil ajustada:** antes, un celular en horizontal con suficiente ancho (ej. 714×360) podía clasificarse como "Tablet" solo por el ancho. Ahora también se considera el alto: si es menor a 500px, se clasifica como "Móvil" sin importar el ancho. Si tu script dependía de la clasificación anterior en ese rango de viewport, `AlanUI:ForzarTipo("Tablet")` sigue disponible para forzarla manualmente.
- **`AlanUI:Profiler()` contaba mal la cantidad de Flags activos:** siempre devolvía `Flags: 0`, sin importar cuántos hubiera. `AlanUI.Flags` es una tabla proxy (los valores reales viven en otro lado por dentro), y `pairs()` no pasa por ese proxy — iteraba sobre una tabla que siempre está vacía por diseño. Ahora cuenta sobre el lugar correcto. Solo afectaba ese número del diagnóstico, nada funcional.

## 🆕 Novedades v2.12

Secciones colapsables: cada sección de la interfaz ahora se puede colapsar/expandir con un click, para que el usuario pueda ocultar temporalmente las partes de la UI que no está usando sin perder su lugar.

- **Secciones colapsables por defecto:** `Tab:CrearSeccion("Nombre")` crea una sección con header clickeable — flecha a la izquierda (▶ colapsada / ▼ expandida) + título. Clickear el header entero (no solo la flecha) expande/colapsa. El header es un botón transparente que ocupa todo el ancho, para que sea fácil de tocar en móvil.
- **Compatible con el código existente:** `Tab:CrearSeccion("Nombre")` sin segundo parámetro funciona igual que siempre, ahora con el comportamiento colapsable agregado. Para volver al header solo-texto de antes: `Tab:CrearSeccion("Nombre", { Colapsable = false })`.
- **Arrancar colapsada:** `Tab:CrearSeccion("Nombre", { ColapsadaPorDefecto = true })` — útil para secciones avanzadas que no todos los usuarios necesitan ver siempre. Solo tiene efecto si la sección es colapsable.
- **El estado colapsado NO persiste entre sesiones:** es un ajuste visual efímero, no se guarda en el `.json`. Cada vez que se abre la ventana, todas las secciones arrancan en su estado por defecto (expandidas, o colapsadas si se pasó `ColapsadaPorDefecto = true`).
- **Interacción con el buscador global:** mientras hay búsqueda activa, todas las secciones se expanden automáticamente — así el usuario ve los resultados sin tener que abrir cada sección a mano. Al limpiar la búsqueda, cada sección vuelve a su estado previo (las que estaban colapsadas vuelven a estar colapsadas).

```lua
-- Colapsable por defecto
local Seccion = Tab:CrearSeccion("General")

-- Sin colapso (comportamiento de siempre)
local SeccionFija = Tab:CrearSeccion("Otra", { Colapsable = false })

-- Colapsable, pero arranca colapsada
local SeccionAvanzada = Tab:CrearSeccion("Avanzado", { ColapsadaPorDefecto = true })
```

> 📝 **Actualización (v2.12.4):** en v2.12 colapsar/expandir era instantáneo (`Visible`, sin tween de tamaño). Desde v2.12.4 ahora **sí anima la altura** al hacerlo con un click; solo las transiciones que dispara el buscador siguen siendo instantáneas a propósito.

## 🆕 Novedades v2.11

Nuevo sistema de diagnóstico de entorno: AlanUI ahora sabe en qué tipo de dispositivo corre y comunica claramente qué funciones soporta, en vez de fallar en silencio.

- **`AlanUI.Capacidades` extendido** con `Tipo` (`PC`/`Movil`/`Tablet`/`Consola`/`Studio`/`Desconocido`), `Plataforma`, `ViewportSize`, `EsStudio`, `TieneTouch`, `TieneMouse`, y los derivados `EsTactil`/`EsEscritorio`/`EsTouchOnly`. Se recalcula en vivo si el viewport cambia (rotar el celular, redimensionar la ventana en Studio).
- **`AlanUI:VerificarSoporte(nombre)`** — verifica si una función puntual (`"Archivos"`, `"Drawing"`, `"SetClipboard"`, etc.) está disponible en el entorno actual, con nivel (`requerido`/`recomendado`/`opcional`) y mensaje explicando qué se pierde si no está.
- **`AlanUI:ForzarTipo(tipo)` / `LiberarForzado()`** — para corregir manualmente una clasificación equivocada (una tablet detectada como móvil, por ejemplo). Persiste entre re-ejecuciones del script en la misma sesión.
- **`AlanUI:DiagnosticoCompleto()`** — snapshot completo pensado para reportes de bug.
- **Nueva sección "🖥️ Diagnóstico del entorno"** en la pestaña Preinstalada, entre "Información" y "Apariencia": muestra el dispositivo detectado, cuántas funciones están soportadas, y advertencias específicas solo cuando falta algo.

```lua
if AlanUI:VerificarSoporte("Drawing").ok then
    miESP()
end

AlanUI.Eventos.TipoCambiado:Connect(function(tipo) print("Ahora:", tipo) end)
```

## 🆕 Novedades v2.11.2 (patch)

Correcciones y mejoras chicas sobre `Keybind`, `Input` y el sistema de guardado, de una tanda de revisión de código:

- **`Keybind` ahora sí escucha la tecla asignada después de asignarla:** antes, el `Callback` se disparaba una única vez, en el instante en que se terminaba de capturar la tecla — presionarla después en el juego no hacía absolutamente nada, había que armar un `UserInputService.InputBegan` propio aparte. Ahora queda un listener persistente escuchando mientras la ventana viva (teclado simple, con modificadores, y gamepad).
- **El `Callback` ya no se dispara al asignar o reasignar la tecla, solo al presionarla en el juego:** antes, el propio acto de capturar una tecla nueva ya disparaba el `Callback` una vez — para un `Callback` tipo alternar (toggle), esto hacía que asignar la tecla ya cambiara el estado antes de que el usuario la presionara ni una vez. Si tu script dependía de ese disparo al asignar, movelo a un listener propio sobre `AlanUI.Eventos.FlagCambiada` para ese flag.
- **Detección de conflictos entre `Keybind`:** si dos `Keybind` de la misma ventana terminan compartiendo la misma tecla (con los mismos modificadores, si usan `ConModificadores`), aparece una notificación avisando cuáles — sin bloquear la asignación ni modificar ninguno de los dos automáticamente, la decisión queda del lado de quien usa el script. Se revisa tanto al reasignar una tecla a mano como al cargar un perfil guardado que ya tenía el conflicto (una sola notificación agrupada por combinación, no una por Keybind involucrado).
- **`GetPlatform()` ya no puede tumbar la carga del módulo:** en Studio (y en ejecutores con sandbox restrictivo), ese método de `UserInputService` requiere una capability que un `LocalScript` no tiene — llamarlo sin protección hacía que la excepción cortara la carga completa de AlanUI. Ahora está protegido con `pcall`, cayendo a `nil` como valor seguro (el resto del código ya sabe manejar esto, recurriendo a la heurística normal de detección de entorno).
- **Contador de caracteres en `Input`:** aparece como aviso ("180/200") cuando el texto se acerca al límite de `MaxCaracteres` (80% o más) — antes el límite era invisible y solo se notaba cuando el texto ya se había cortado. Se puede desactivar por campo con `OcultarContador = true`.
- **Versionado del formato de guardado:** los `.json` guardados ahora incluyen un campo interno `__version`, pensado para poder migrar automáticamente archivos viejos si el formato cambia en el futuro. No afecta nada de lo que ya tenías guardado — los archivos anteriores a este cambio se siguen leyendo exactamente igual.

## 🆕 Novedades v2.10.2 (patch)

Correcciones de código y mejoras encontradas al auditar la documentación:

- La sombra de la ventana ahora cubre **toda la pantalla** (antes era un halo ajustado al borde), con un fade-in suave de 0.25s al abrir. (Antes su fade-in no se ejecutaba por un error de nombre de propiedad; ahora sí.)
- Headers de `Dropdown`/`ColorPicker` ahora usan el mismo sistema anti-"tap perdido" que el resto de controles.
- `AlanUI.Motion.HoverIntensidad` ahora sí se usa como default real de `Utils.Hover` (antes estaba declarado pero sin conectar).
- Los swatches del `ColorPicker` ahora cambian de color de borde al cambiar de tema.
- El hover de filas/toggles/sliders usaba una duración fija de 0.15s en vez de `AlanUI.Motion.Hover` (0.12s) — ahora es consistente, y `Utils.Hover` acepta un cuarto parámetro opcional `duracion` para casos que necesiten overridearlo.
- La barra lateral de tabs ahora tiene scroll: con 15+ tabs, antes se desbordaba sin forma de verlos todos.

## 🆕 Novedades v2.10.1 (patch)

Cuatro correcciones sobre las mejoras visuales de v2.10, encontradas en una revisión posterior. No agrega funcionalidad nueva.

- **Las sombras de la ventana quedaban visibles al minimizar:** al minimizar, la ventana pasa a tamaño (0,0) y se oculta, pero las 3 capas de sombra detrás nunca se ocultaban con ella — quedaban como cuadrados oscuros flotando en el centro de la pantalla, visibles sobre todo en fondos claros. Ahora las sombras siguen la visibilidad de la ventana además de su tamaño y posición.
- **Hover inconsistente en tabs y `RadioGroup`:** por un error de parámetro, los botones de pestaña (barra lateral y superior) y los botones de `RadioGroup` recibían una intensidad de hover de 12% en vez del 20% del resto de la interfaz — se sentían "más apagados" que el resto de los controles. Corregido en los tres puntos.
- **El fix de "primer tap perdido en scroll" (v2.10) solo cubría `Boton`:** se extendió a todos los controles que viven dentro de la página con scroll de cada tab — `Toggle`/`Casilla`, las opciones del `Dropdown`, `RadioGroup`, los swatches del `ColorPicker`, y las tres variantes del `Keybind`.
- **Pequeño solape entre el hitbox ampliado del `Slider` y su campo de valor:** el área de toque ampliada del Slider se solapaba 2px con el borde inferior del campo de texto de encima. Ajustado para que ambos queden exactamente pegados, sin solaparse ni dejar hueco.

---

## 🆕 Novedades v2.10

Doce mejoras visuales y de experiencia táctil, sin tocar lógica de negocio ni romper compatibilidad con nada existente.

### 🎨 Visual

- **Sombra suave detrás de la ventana:** tres capas de `Frame` semitransparente detrás de la ventana principal, dándole sensación de profundidad — antes flotaba "pegada" al juego, sin ningún efecto de elevación.
- **Esquinas más redondeadas:** el radio de la ventana principal pasó de 10 a 14px, un look más moderno.
- **Hover más marcado:** el aclarado al pasar el mouse sobre un control subió de 14% a 20% — la interfaz se siente más receptiva.
- **Más espacio entre secciones:** de 8 a 14px de separación vertical entre secciones dentro de un tab.

### 📱 Experiencia táctil / mobile

- **Hitbox más grande en los `Slider`:** el área de toque real ahora mide 20px (antes 10px, el mismo alto que la barra visual) — mucho más fácil de tocar con el dedo, sin cambiar cómo se ve la barra.
- **Botones más responsivos dentro de listas con scroll:** los botones usaban `MouseButton1Click`, que en un `ScrollingFrame` a veces "comía" el primer tap pensando que era el inicio de un scroll. Ahora usan un patrón de presionar/soltar con tolerancia de movimiento, igual de preciso pero sin ese problema.
- **Apertura más ágil en todos los dispositivos:** la animación de apertura de la ventana ahora dura 0.25s (antes 0.45s con teclado y 0.3s en mobile).
- **Tamaño mínimo de texto más alto en mobile:** el piso de la escala de texto subió de 6px a 9px en dispositivos táctiles — 6px es prácticamente ilegible en un celular a resolución alta.

### 🧩 Controles nuevos

- **`Seccion:Divider`:** separador visual liviano entre grupos de controles relacionados dentro de una sección — una línea delgada, con o sin texto, mucho más liviano que usar `Parrafo` para lo mismo.
- **`Icono` opcional en `Seccion:Boton`:** botones tipo "💾 Guardar" o "🗑️ Eliminar" con un simple `cfg.Icono = "💾"`, sin agregar ninguna instancia extra.
- **Paleta de colores comunes en `ColorPicker`:** una fila de 8 swatches (rojo, verde, azul, amarillo, magenta, cian, blanco, negro) arriba de los sliders RGB — un click para los colores más usados, en vez de escribir hex o mover 3 sliders.

```lua
Seccion:Divider({ Texto = "Ajustes avanzados" })

Seccion:Boton({
    Texto = "Guardar",
    Icono = "💾",
    Callback = function() end,
})
```

---

## 🆕 Novedades v2.9.1 (patch)

Seis correcciones sobre los controles nuevos de v2.9, encontradas en una revisión posterior. No agrega funcionalidad nueva.

- **Crash de `Keybind` con `Defecto = Enum.KeyCode.X` + `ConModificadores = true`:** si se pasaba un `Enum.KeyCode` suelto como `Defecto` junto con `ConModificadores = true`, el control fallaba al crearse (intentaba leer `.KeyCode` sobre un `EnumItem`). Ahora `Defecto` se normaliza automáticamente al formato de tabla que `ConModificadores` espera.
- **Inconsistencia de tipo en `Keybind` táctil con modificadores:** en móvil sin teclado, rotar entre teclas comunes con toque largo podía dejar `valor` a veces como tabla, a veces como `Enum.KeyCode` suelto, según el momento. Ahora se mantiene el tipo consistente con `ConModificadores`.
- **Carga de un `Keybind` con tecla inválida devolvía `nil`:** si el `.json` guardado tenía el nombre de una tecla que ya no existe, la reconstrucción devolvía `nil` en vez de caer al valor por defecto seguro (`Enum.KeyCode.Unknown`).
- **`Input` con `Tipo = "pattern"` y un `Regex` que ya trae `^`/`$` nunca validaba nada:** en un patrón Lua, `^` solo es ancla como primer carácter — pasar `Regex = "^%d+$"` terminaba anclando dos veces (`^^%d+$$`), que no matchea nunca. Ahora se aceptan patrones con o sin anclas explícitas indistintamente.
- **`ColorPicker.Set()` (público) no disparaba el `Callback`:** una caché interna pensada para el arrastre en vivo hacía que actualizar el color por código nunca llegara a ejecutar el `Callback`, a diferencia de escribir el hex a mano (que sí lo disparaba). Ambos caminos ahora se comportan igual.
- **`Seccion:Progreso` generaba un ciclo de autoguardado innecesario al crearse:** escribía su valor inicial a través del mismo mecanismo que dispara guardado automático, igual que ya se había corregido para `Label` en v2.8. Ahora escribe directo al almacenamiento interno, sin ese efecto secundario.

> ⚠️ **Si guardaste algún `Keybind` con v2.8 o anterior:** por el bug de serialización corregido en v2.9, esos guardados quedaron corruptos o vacíos — no se recuperan solos al actualizar. Reasigná esos Keybinds una vez después de actualizar y a partir de ahí se guardarán y cargarán correctamente.

> 📝 **Nota sobre `Input` con `Tipo = "number"`:** igual que el resto de `Input`, la validación y el `Callback` se disparan al perder el foco (`FocusLost`), típicamente presionando Enter o tocando fuera del campo — no en cada tecla mientras se escribe. Si el usuario cambia de campo sin presionar Enter, el valor igual queda guardado en el Flag, pero el `Callback` solo corre si `FocusLost` reporta que se cerró con Enter.

---

## 🆕 Novedades v2.9

Cinco controles nuevos, pensados para llenar huecos concretos de la API sin tocar el comportamiento de nada existente.

### 🎨 `ColorPicker` con campo Hex
Debajo de los tres sliders R/G/B ahora hay un campo de texto `#RRGGBB` (también acepta la forma corta `#RGB`). Escribir un hex válido mueve los tres sliders de una vez; mover los sliders actualiza el hex automáticamente. Un hex inválido simplemente se revierte al último color válido al perder el foco, sin marcar error.

### 🔢 `Input` con validación (`Tipo`)
`Seccion:Input` acepta ahora un `cfg.Tipo` opcional:
- `Tipo = "number"` — solo acepta números; con `Min`/`Max` opcionales, el valor se recorta a ese rango. El `Callback` recibe un número real, no un string.
- `Tipo = "pattern"` — valida contra un patrón Lua (`cfg.Regex`), anclado a la cadena completa.

Sin `Tipo`, el comportamiento es exactamente el de siempre (texto libre).

```lua
Seccion:Input({
    Texto = "Nivel objetivo",
    Flag = "nivelObjetivo",
    Tipo = "number", Min = 1, Max = 100,
    Callback = function(n) print("Nivel:", n) end, -- n es un numero
})
```

### 🔘 `Seccion:RadioGroup` (nuevo control)
Alternativa a `Dropdown` cuando hay pocas opciones (2-4 es el caso típico): todas quedan visibles en una fila horizontal, sin desplegar nada. Selección única.

```lua
Seccion:RadioGroup({
    Texto = "Modo",
    Flag = "modo",
    Opciones = {"Farm", "PvP", "Raid"},
    Defecto = "Farm",
    Callback = function(v) print("Modo:", v) end,
})
```

### 📊 `Seccion:Progreso` (nuevo control)
Barra de progreso de solo lectura (el usuario no puede arrastrarla), pensada para cooldowns, progreso de auto-farm, carga de datos, etc. Se actualiza con `Set(0-100)`.

```lua
local barra = Seccion:Progreso({ Texto = "Progreso del farm" })
barra.Set(45) -- 45%
```

### ⌨️ `Keybind` con modificadores (`ConModificadores`)
Con `cfg.ConModificadores = true`, el Keybind captura también si Ctrl/Shift/Alt estaban presionados junto con la tecla — el valor pasa de ser un `Enum.KeyCode` suelto a una tabla `{KeyCode, Ctrl, Shift, Alt}`. Sin esa opción, el comportamiento es idéntico al de siempre. El texto mostrado se arma solo, por ejemplo "Ctrl+Shift+F".

```lua
Seccion:Keybind({
    Texto = "Combo de ataque",
    Flag = "comboAtaque",
    ConModificadores = true,
    Callback = function(v)
        print(v.Ctrl, v.Shift, v.Alt, v.KeyCode)
    end,
})
```

### 🐛 Corrección de guardado

- **Los `Keybind` no se guardaban ni cargaban correctamente:** `Enum.KeyCode` (y ahora también la tabla de modificadores) nunca tuvo un tratamiento especial al guardar, a diferencia de `Color3` — `HttpService:JSONEncode` no sabe serializar un `EnumItem`, así que un Keybind guardado quedaba corrupto o vacío al recargar. Ahora se empaqueta a su nombre de texto y se reconstruye correctamente al cargar, igual que ya pasaba con los colores. **Los Keybinds guardados con v2.8 o anterior no se recuperan solos al actualizar — hay que reasignarlos una vez** (ver nota en "Novedades v2.9.1" más arriba).

---

## 🆕 Novedades v2.8

Esta ronda sale de varias auditorías propias enfocadas en rendimiento, limpieza de conexiones, y separación de responsabilidades dentro de la pestaña Preinstalada.

### 💾 Guardado rediseñado: dos sistemas independientes

- **Preinstalada ahora gestiona SOLO sus propios ajustes** (tema, orientación, escala, ancho/alto de ventana, tamaño de texto) con su propio Guardar/Cargar/Eliminar (`SM:GuardarUI`/`CargarUI`/`ListarUI`/`EliminarUI`), en una carpeta separada del resto.
- **Nueva sección "Perfiles de script" dentro de Preinstalada:** gestiona los Flags de tu propio script (todo lo que no sea ajuste de interfaz) con Dropdown + Guardar como nuevo perfil + Cargar + Eliminar. Aparece automáticamente en cualquier script que use AlanUI, sin escribir código extra.
- `AlanUI:MarcarComoUI(flag)` (nuevo): marca un Flag como exclusivo de la interfaz para que el sistema de perfiles nunca lo incluya ni lo sobreescriba.
- **Autoguardado rediseñado:** en vez de escribir a disco ~0.4s después de cada cambio, ahora revisa cada 10 segundos si hubo algún cambio real y solo entonces guarda una vez — mismo resultado, muchas menos escrituras a disco durante una sesión larga.
- **Verificación antes de sobreescribir:** el botón manual de "Guardar" ahora compara contra el archivo existente — si nada cambió, avisa "Ya estaba al día" en vez de reescribir el mismo contenido.
- Toda carga (perfil, ajustes de interfaz, o la carga automática al abrir el script) ahora muestra notificación siempre.

### 🐛 Corrección de botones de la barra de título

- **El botón "✕" no limpiaba los registros internos:** confirmar "Eliminar" llamaba directo a `sg:Destroy()`, sin pasar por la misma limpieza de registros (`registroTema`, `indiceBusqueda`, `registroEscalaTexto`, `AlanUI.Elementos`) que sí hace `Ventana:Destruir()`. Ahora ambos caminos limpian exactamente lo mismo.
- **Áreas táctiles de "cerrar" y "minimizar" superpuestas:** el área de toque real de cada botón es más grande que su ícono visible (para que sea más fácil tocarlos, sobre todo en móvil), pero la separación entre ambos botones no tenía en cuenta ese margen extra — un toque un poco impreciso en "minimizar" podía terminar disparando "cerrar" (que además pide confirmar para destruir la interfaz). Ahora la separación entre centros es suficiente para que las zonas de toque invisibles tampoco se pisen entre sí.

### 🐛 Corrección de tooltips

- **Cierre impredecible al mantener presionado en una fila entera:** desde que el tooltip por "mantener presionado" se extendió a la fila completa (no solo el ícono "?"), el cierre por click-afuera solo funcionaba si el toque siguiente caía fuera de esa fila entera y del panel — un área grande, así que la mayoría de los toques "siguientes" caían adentro y no cerraban nada. Ahora el siguiente click o toque, sin importar dónde caiga, cierra el tooltip abierto (sin contar el mismo toque que lo abrió).

### 🐛 Corrección de animaciones

- **Dropdown/ColorPicker que a veces no se abrían del todo:** el sistema que evita que dos animaciones compitan por la misma propiedad (cancelando la anterior antes de arrancar la nueva) cacheaba solo por objeto, sin distinguir qué propiedad se animaba. Un mismo `Frame` puede tener su color animado por el efecto hover Y su tamaño animado al abrirse (el caso de Dropdown/ColorPicker) — con la cache por-objeto-solamente, un simple paso del mouse cerca de un click cancelaba a mitad de camino la animación de apertura, dejando el panel visualmente cerrado (o "temblando" a medio camino) aunque el estado interno dijera que sí se había abierto. Ahora la cache distingue por objeto **y** por las propiedades animadas — dos animaciones sobre propiedades distintas del mismo objeto ya no se cancelan entre sí.

### 🐛 Corrección de guardado

- **`Label.Set()` escribía a disco en cada llamada:** un `Label` pasaba su valor por el proxy de `AlanUI.Flags`, que programa un guardado en disco cada vez que se le asigna algo. `Label` se usa típicamente para valores que cambian todo el tiempo (contador de FPS, HUD de combate, distancia al objetivo) — eso eran escrituras a disco sin parar de un valor que nunca debería persistirse, y de paso, al reabrir el script, se restauraba por un instante el último número guardado antes de que tu propio código lo actualizara. Ahora `Label` escribe directo al almacenamiento interno (sigue siendo legible con `ObtenerFlag`/`Get()` como siempre) sin pasar por el proxy que dispara guardado.
- **Colores (`ColorPicker`) que se perdían al guardar:** `SM:Guardar` codificaba `_flagsReales` como argumento de la llamada a `pcall`, así que si `HttpService:JSONEncode` fallaba, ese error no quedaba protegido por el `pcall` y se escapaba directo. Además, `JSONEncode` no sabe serializar un `Color3` (no es un tipo JSON válido) y lo convertía en `null` sin avisar — cualquier `ColorPicker` guardado se perdía en silencio. Ahora todo el trabajo (empaquetar `Color3` a `{R,G,B}`, codificar, escribir) corre dentro del mismo `pcall`.

### 🧹 Limpieza de conexiones

- `AlanUI:DesconectarYLimpiar(conexion)` (nuevo): desconecta una conexión y la saca del registro global de limpieza en un solo paso — para conexiones que ya se registraron con `RegistrarConexion` pero se desconectan manualmente antes de que la ventana se destruya (tooltips, paneles desplegables). Sin esto, la entrada quedaba "muerta" acumulándose en el registro.
- La cámara (`Workspace.CurrentCamera`) ahora se re-detecta si cambia en caliente, en vez de quedar atada para siempre a la que estaba activa al abrir la ventana.

### ⚡ Rendimiento

- El indicador de "Salud" de la pestaña Preinstalada ya no recorre toda la GUI (`GetDescendants()`) cada segundo para contar objetos — ahora lleva un contador en tiempo real que sube y baja solo al crear/destruir instancias.
- El contador de FPS pasó de un loop propio con `task.wait()` a una conexión estándar de `RunService.Heartbeat`, integrada al mismo sistema de limpieza que el resto de la librería.
- `Dropdown.ActualizarOpciones()` (usado para refrescar listas, como la de perfiles guardados) ya no destruye y recrea todos los botones de la lista — reutiliza los que siguen existiendo y solo toca los que cambiaron.
- El arrastre del `Slider` ya no pasa por la maquinaria genérica de animación en cada pixel de movimiento — usa un `Tween` dedicado y liviano, pensado específicamente para eventos de alta frecuencia.

### 🎨 Visual

- Los botones de pestaña de la barra lateral/superior ahora sí cambian de color al cambiar de tema (antes quedaban con el color del tema con el que se habían creado).
- El círculo "?" del tooltip ya no se superpone con el texto en filas angostas con valores largos pegados a la derecha (por ejemplo "Memoria (aprox...)" o "Tamaño de la interfaz" en la pestaña Preinstalada).

---

## 🆕 Novedades v2.7

Esta ronda sale de una auditoría técnica externa (13 propuestas concretas), evaluada una por una contra el código real antes de tocar nada — ninguna se aplicó a ciegas. Esto es lo que se implementó:

* 🔀 **Visibilidad condicional entre controles (`VisibleSi`, nuevo):** cualquier elemento puede ocultarse o mostrarse según el valor de OTRO flag, sin que tengas que llamar `.Set()` a mano. Pensado para el caso típico "si Auto Farm está activo, mostrar Distancia/Prioridad/Ignorar Amigos". Se re-evalúa solo cada vez que cambia cualquier flag.
  ```lua
  SeccionCombate:Slider({
      Texto = "Distancia",
      VisibleSi = function() return AlanUI.Flags.AutoFarm == true end,
  })
  ```
* 📡 **Eventos globales (`AlanUI.Eventos`, nuevo):** reacciona a cambios importantes sin envolver manualmente cada control. `FlagCambiada` (cualquier escritura en `AlanUI.Flags`), `TabCambiada` y `TemaCambiado` ya se disparan solos.
  ```lua
  AlanUI.Eventos.FlagCambiada:Connect(function(flag, valor)
      print("Cambió:", flag, "→", valor)
  end)
  ```
* 🔔 **Notificaciones con `Tipo`, `Prioridad` y `Persistente` (nuevo):** cuatro tipos semánticos (`Info` / `Success` / `Warning` / `Error`) con su propio color de acento, notificaciones que no se cierran solas (`Persistente = true`, se descartan con un click), y una cola que respeta prioridad en vez de ser siempre FIFO.
  ```lua
  AlanUI:Notificar({ Titulo = "Error", Texto = "Algo falló", Tipo = "Error", Prioridad = 2 })
  ```
* 💾 **Perfiles de configuración (`SM:CambiarPerfil`, nuevo):** cambia entre archivos de configuración completos ("Farm", "PvP", "Raid"...) con una sola llamada, sin recrear la ventana. La infraestructura de archivos con nombre ya existía (`Guardar`/`Cargar` siempre aceptaron un nombre); esto es el método de conveniencia que además redirige el autoguardado nativo.
  ```lua
  AlanUI.SaveManager:CambiarPerfil(Ventana, "Farm")
  ```
* 🩺 **Profiler bajo demanda (`AlanUI:Profiler()`, nuevo):** una foto instantánea (Flags, Elementos, conexiones, hilos, dibujos, objetos de GUI, memoria aproximada) sin depender de tener la pestaña Preinstalada abierta. Complementa al panel de Salud que ya corría en vivo ahí.
* 🐞 **`AlanUI.DebugMode` (nuevo):** en `true`, algunos `pcall` que hoy fallan en silencio a propósito (por ejemplo, sincronizar el color de un elemento de tema ya destruido) además avisan por consola — útil mientras estás desarrollando tu propio script.

### 🔧 Correcciones internas (sin cambios de API)

- **Fuga de memoria en `AlanUI.Elementos`:** los flags de una ventana ya destruida quedaban viviendo para siempre en esta tabla global. Ahora se limpia junto con el resto de los registros internos (tema, buscador, escala de texto) al crear o destruir una ventana.
- **Aliasing en Dropdown Multi:** la selección de un `Dropdown` con `Multi = true` se exponía por referencia directa — mutar la tabla obtenida de `AlanUI.Flags` o de `Get()` desde afuera podía corromper el estado visual del control sin que se notara. Ahora siempre se entrega una copia (`table.clone`, con fallback manual para ejecutores viejos).
- **Toggle y Casilla comparten su lógica interna** (Flag, registro, tecla asignada, disparo de Callback, Set/Get) en un único lugar en vez de estar duplicada palabra por palabra. Sin cambios visibles para quien usa la librería, pero un fix futuro en uno de los dos ahora aplica automáticamente al otro.

> 💡 La auditoría evaluó 13 propuestas en total; 5 quedaron afuera a propósito (dividir el registro de temas por categoría, indexar el buscador por palabra, un sistema de plugins externo, y dividir `CrearVentana` en módulos internos) porque agregaban complejidad sin un beneficio medible al tamaño real en que se usa esta librería, o porque conviene resolverlas después de otro cambio estructural primero.

---

## 🆕 Novedades v2.6

* 📏 **Cajas de valor del Slider, más grandes:** la fila completa de cada `Slider` creció (44px → 54px de alto) para poder darle a la caja de valor un tamaño real (110×32, antes 54×20) sin apretarse contra la barra ni el label. Afecta a todos los sliders de tu interfaz, incluida la pestaña Preinstalada.
* 🏷️ **Crédito de AlanUI, fijo:** el `Titulo`/`Subtitulo` de la ventana sigue siendo 100% personalizable (esa es la identidad de **tu** script), pero el subtítulo ahora termina siempre en "• AlanUI" — sin ninguna forma de sacarlo desde `CrearVentana(cfg)`. El crédito del creador (`@alanbeikersFFXD`) sigue fijo en la pestaña Preinstalada, como ya estaba.
* 👆 **Tooltip por mantener presionado (nuevo, además del "?"):** mantener presionado en cualquier parte de una fila (no solo en el ícono) también muestra su tooltip, pensado especialmente para móvil. Distingue automáticamente un "mantener quieto" real de un gesto de scroll (si te mueves más del umbral —18px en touch, 10px con mouse— mientras mantienes presionado, no se abre). Además de vigilar el toque, reacciona al evento `TouchLongPress` de la fila. El **siguiente** click o toque en cualquier lado cierra el tooltip abierto.
* ⚠️ **Confirmación antes de eliminar la ventana:** tocar la "✕" ahora pide confirmar ("Cancelar" / "Eliminar") antes de destruir la interfaz — evita perder la sesión por un toque de más, sobre todo en móvil. La API `Ventana:Destruir()` (para uso programático desde tu propio script) sigue siendo instantánea a propósito, sin diálogo.

### 🔧 Corrección de bugs (dos rondas de auditoría)

Se revisaron dos análisis externos completos de la librería (uno propio y otro de un modelo distinto) verificando cada punto contra el código real antes de tocar nada. De ahí salieron estas correcciones:

- **Fuga real en re-ejecuciones:** dos conexiones de `UserInputService` (`InputChanged`/`InputEnded`) vivían a nivel de módulo, fuera del sistema de auto-limpieza — se acumulaban para siempre en cada re-ejecución del script. Es la corrección más importante de esta ronda.
- El registro de escala de texto (`registroEscalaTexto`) tampoco se reiniciaba entre ejecuciones — mismo tipo de fuga, ya resuelto.
- Los bordes (`UIStroke`) de la ventana principal, el tooltip, la Casilla, el ColorPicker, las notificaciones, las tarjetas de sección y la píldora de minimizar no se actualizaban al cambiar de tema — quedaban pegados al color del tema inicial. `Utils.Frame` ahora acepta `ClaveTemaBorde` para registrar esto automáticamente.
- El tooltip abierto no se cerraba si la ventana se destruía mientras estaba visible (su overlay es un `ScreenGui` aparte que sobrevive por su cuenta).
- `Input.Set(v)` (el método público) no disparaba el `Callback`, a diferencia de Toggle/Slider/Dropdown/Keybind/ColorPicker, que sí lo hacen — ahora es consistente en todos los controles.
- Guardado automático bajo el archivo equivocado: si re-ejecutabas el script con `AutoGuardar = false` después de una sesión con `AutoGuardar = true`, los cambios podían guardarse silenciosamente bajo el `NombreConfig` de la ventana anterior (ya destruida).
- Conexiones de arrastre (`Utils.Arrastrable`) y de captura de tecla (`Keybind` en espera) ahora se registran en el sistema global de limpieza, en vez de depender únicamente de que el usuario termine el gesto/asignación por su cuenta.

---

## 🆕 Novedades v2.5

* 🔎 **Buscador del Dropdown más inteligente:** al escribir, la primera coincidencia visible se resalta automáticamente, y presionar **Enter** la selecciona al instante — sin tener que clickearla. Funciona en cualquier `Dropdown` con más de 8 opciones (donde ya se agrega la barra de búsqueda sola).
* 🧭 **Indicador de pestaña activa, rediseñado:** antes la pestaña seleccionada pintaba todo su fondo en el color de acento. Ahora usa una barrita delgada (lateral en modo vertical, inferior en modo horizontal) — el acento pasa a significar "esto está activo" en vez de ser un bloque de color grande. El fondo del tab se mantiene neutro siempre.
* 🎯 **Tooltips más precisos:** el círculo "?" ahora calcula su posición contra el ancho real del texto y contra dónde empieza de verdad el contenido de la derecha de cada fila (switch, badge, caja de texto, botón), en vez de un margen fijo — se ajusta distinto para cada tipo de control automáticamente. También se actualiza en vivo si cambias el tamaño de texto desde la pestaña Preinstalada.
* 🌗 **Más contraste en los temas Negro y Blanco:** el fondo de las secciones (`Panel`) ahora se distingue más claramente del fondo general (`Background`), para que la jerarquía visual de la ventana se note mejor de un vistazo.
* 🎬 **`AlanUI.Motion`:** tabla de duraciones de animación con nombre (`Directo`, `Hover`, `Press`, `Expand`, `Page`, `Modal`, `Spin`) en vez de números sueltos repartidos por el código — pensada como base para que futuras animaciones de la librería (y las tuyas, si quieres reusarla) sigan una misma personalidad de movimiento.

```lua
-- AlanUI.Motion sí es público — puedes usar sus duraciones en tus
-- propios Tweens para que se sientan consistentes con el resto de
-- la interfaz:
local info = TweenInfo.new(AlanUI.Motion.Hover, Enum.EasingStyle.Quad)
game:GetService("TweenService"):Create(miFrame, info, {BackgroundTransparency = 0}):Play()
```

---

## 🆕 Novedades v2.4

* 📊 **Monitor de rendimiento real:** la pestaña "Preinstalada" ahora muestra, además del FPS, el **Frame Time (ms)**, un **estado con semáforo** (🟢 Excelente / 🟡 Normal / 🔴 Degradado según el FPS) y la **memoria aproximada** del cliente (cuando el ejecutor la expone — si no, el dato simplemente no aparece en vez de mostrar un número falso).
* ✨ **Feedback visual al pasar el cursor (hover):** botones, filas de Toggle/Casilla/Slider, Dropdown, ColorPicker y pestañas ahora se iluminan sutilmente al pasar el mouse por encima. Es automático — no requiere ningún cambio en tu código.
* 🎨 **Degradado sutil en el color de acento:** el relleno del Slider, las barras del ColorPicker y la barra de carga inicial ahora tienen un leve degradado (en vez de color plano), y se recalcula solo al cambiar de tema. También automático, sin cambios de código necesarios.
* ⚠️ **Advertencias de desarrollo (nuevo):** AlanUI ahora detecta configuraciones incompletas o con errores de tipeo **antes** de crear el control, y avisa en la consola de Roblox (F9) sin romper tu script:
  - Un `Slider` sin `Defecto` → avisa y usa el `Min` automáticamente.
  - Un `Slider` con `Min` mayor o igual a `Max` → avisa y corrige `Max` para evitar que la barra se rompa.
  - Cualquier control con un `Callback` que no es una función (típico error de tipeo) → avisa y lo ignora en vez de crashear.
  - Un `Button` sin `Callback` → avisa, porque un botón así no tiene ninguna utilidad.

  > 💡 A propósito, un `Toggle` o `Casilla` **sin** `Callback` no genera ninguna advertencia — es un patrón válido en AlanUI (guardar el flag y leerlo después con `AlanUI:Try()`), no un error.

  Esto es distinto del sistema de captura de errores que ya existía (`AlanUI:ObtenerErrores()`), que sigue atrapando los errores que tira tu propio `Callback` **mientras corre** — ahora ambos trabajan juntos: uno revisa la configuración antes de crear el control, el otro protege la ejecución después.

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT — revisa el archivo [LICENSE](LICENSE) para más detalles.
