-- ══════════════════════════════════════════════════════════════
--  AlanUI_Vitrina.lua
--  Vitrina interactiva de TODAS las características de AlanUI.
--  Cada control aparece con un Tooltip explicando qué prueba.
-- ══════════════════════════════════════════════════════════════

local URL_ALANUI = "https://raw.githubusercontent.com/alanbeikers9/AlanUI/refs/heads/main/AlanUI.lua"
local AlanUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/alanbeikers9/AlanUI/refs/heads/main/AlanUI.lua"))()

-- Datos de la carga, para la prueba "Carga de la librería" y el diagnóstico.
local CARGA = {
    Metodo = "loadstring(game:HttpGet(url))",
    Desarrollo = false,
    URL = URL_ALANUI,
    Funciones = {
        loadstring = type(loadstring) == "function",
        HttpGet = (pcall(function() return type(game.HttpGet) == "function" end)),
        request = type(request) == "function" or (type(http) == "table" and type(http.request) == "function"),
        readfile = type(readfile) == "function",
    },
}

-- Iconos propios activos para la pestaña Preinstalada y los Dialogo() por tipo.
AlanUI.Opciones.IconosPropios = true
AlanUI.Opciones.TextoFijo = true

-- Iconos de prueba para comprobar los respaldos (ver pestañas "Icono roto" y "Sin icono").
AlanUI.Iconos.prueba_rota = { Id = 0, Respaldo = "🧪" }

-- ── Tema custom de demo (aparece en el selector de temas) ──────
AlanUI.ThemeManager:AgregarTema("DemoNeon", {
    Background      = Color3.fromRGB(30, 15, 45),
    BackgroundDark  = Color3.fromRGB(18, 8, 30),
    BackgroundLight = Color3.fromRGB(45, 25, 65),
    Accent          = Color3.fromRGB(220, 60, 200),
    AccentLight     = Color3.fromRGB(240, 130, 230),
    Highlight       = Color3.fromRGB(255, 180, 250),
    Text            = Color3.fromRGB(240, 240, 240),
    TextDark        = Color3.fromRGB(220, 220, 220),
    Border          = Color3.fromRGB(10, 5, 18),
    Panel           = Color3.fromRGB(22, 12, 35),
    PanelClaro      = Color3.fromRGB(35, 20, 55),
    Fila            = Color3.fromRGB(28, 16, 42),
    Entrada         = Color3.fromRGB(18, 10, 30),
    Apagado         = Color3.fromRGB(60, 60, 60),
})

-- ── Ventana principal ───────────────────────────────────────────
-- Tamaño base de la vitrina. El "segundo script" simulado (pestaña APIs) lo
-- reutiliza para que, al reemplazar la ventana, la interfaz nueva se vea igual
-- que la primera vez.
local TAMANO_X, TAMANO_Y = 640, 480

-- Aspecto de la vitrina: "moderno" o "clasico" (AlanUI.Opciones.EstiloVisual).
-- La pestaña "Fugas y Mini" tiene botones para abrir una muestra de cada uno.
local ESTILO_VISUAL = "moderno"

local construirVitrina
local conexionHistorial
construirVitrina = function(esPrimera)
local V = AlanUI:CrearVentana({
    Titulo       = "AlanUI Vitrina",
    Subtitulo    = "Panel de evaluación",
    TamanoX      = TAMANO_X,
    TamanoY      = TAMANO_Y,
    TeclaToggle  = Enum.KeyCode.RightControl,
    Buscador     = true,
    AutoGuardar  = false,
    -- Nombre propio: la posición de la ventana se recuerda en un archivo por
    -- NombreConfig (sin él, todos los scripts compartirían "autosave").
    NombreConfig = "vitrina",
    EstiloVisual = ESTILO_VISUAL,
})

V:AgregarSelectorTemas()

-- ══════════════════════════════════════════════════════════════
--  TAB 1 — CONTROLES
-- ══════════════════════════════════════════════════════════════
local TabCtrl = V:CrearTab("Controles", "@configuracion")

-- ── Botones ─────────────────────────────────────────────────────
local SBot = TabCtrl:CrearSeccion("Botones")
SBot:Parrafo({
    Titulo = "Botón",
    Contenido = "Ejecuta un Callback al tocarlo. Variantes: normal, con icono, con texto a la derecha (Interact), Async (con spinner), RichText.",
})

SBot:Boton({ Texto = "Botón simple", Tooltip = "Botón básico sin extras",
    Callback = function() AlanUI:Notificar({ Titulo = "Click", Texto = "Botón simple pulsado", Duracion = 2 }) end })

SBot:Boton({ Texto = "Guardar cambios", Icono = "💾",
    Tooltip = "Botón con icono emoji antepuesto al texto",
    Callback = function() AlanUI:Notificar({ Titulo = "Guardar", Texto = "Icono 💾 probado", Duracion = 2 }) end })

SBot:Boton({ Texto = "Estado del sistema", Interact = "🟢 Activo",
    Tooltip = "Botón con texto dinámico a la derecha (Interact)",
    Callback = function() AlanUI:Notificar({ Titulo = "Estado", Texto = "Interact pulsado", Duracion = 2 }) end })

SBot:Boton({ Texto = "Sincronizar datos", Interact = "~1.5s", Async = true,
    Tooltip = "Botón Async: muestra un spinner mientras el Callback corre",
    Callback = function() task.wait(1.5) end })

SBot:Boton({ Texto = "Aviso importante", RichText = true, Icono = "⚠️",
    Tooltip = "RichText activo: acepta tags como <b> y <font color='#...'>",
    Callback = function() AlanUI:Notificar({ Titulo = "⚠️ Aviso", Texto = "RichText probado", Tipo = "Warning", Duracion = 3 }) end })

-- ── Interruptores ───────────────────────────────────────────────
local SInt = TabCtrl:CrearSeccion("Interruptores (Toggle y Casilla)")
SInt:Parrafo({ Titulo = "Toggle / Casilla", Contenido = "Mismo comportamiento (booleano), distinto estilo. Con 'Desactivar' se apaga otro al encenderse." })

SInt:Toggle({ Texto = "Toggle simple", Flag = "v_tog", Defecto = false,
    Tooltip = "Interruptor estándar" })

SInt:Casilla({ Texto = "Casilla simple", Flag = "v_cas", Defecto = false,
    Tooltip = "Estilo checkbox con dos barritas" })

SInt:Toggle({ Texto = "Modo A (apaga B)", Flag = "v_modoA", Defecto = true,
    Desactivar = { "v_modoB" },
    Tooltip = "Al activarlo, apaga 'Modo B' automáticamente" })

SInt:Casilla({ Texto = "Modo B (apaga A)", Flag = "v_modoB", Defecto = false,
    Desactivar = { "v_modoA" },
    Tooltip = "Al activarlo, apaga 'Modo A' automáticamente" })

SInt:Toggle({ Texto = "Toggle con atajo [F]", Flag = "v_togTecla", Defecto = false,
    Tecla = Enum.KeyCode.F,
    Tooltip = "También se alterna presionando F en el juego" })

-- ── Valores numéricos ──────────────────────────────────────────
local SNum = TabCtrl:CrearSeccion("Valores numéricos")
SNum:Parrafo({ Titulo = "Slider / RangeSlider / NumberStepper", Contenido = "Tres formas de elegir números: rango continuo, rango doble (min-max) y valor exacto con botones." })

SNum:Slider({ Texto = "Velocidad", Flag = "v_slider", Min = 0, Max = 100, Incremento = 5, Sufijo = "%", Defecto = 50,
    Tooltip = "Slider estándar con incrementos de 5. Mantén presionada la manija sin moverla: el tooltip NO debe aparecer. Click en cualquier punto de la barra: la manija salta ahí" })

SNum:Slider({ Texto = "FOV con marcas", Flag = "v_sliderPasos", Min = 70, Max = 120, Incremento = 10, Defecto = 90, Pasos = true,
    Tooltip = "Pasos = true dibuja marcas visuales en cada múltiplo de Incremento" })

SNum:RangeSlider({ Texto = "Distancia (rango)", Flag = "v_range", Min = 0, Max = 200, Incremento = 10, Sufijo = "m", Defecto = { min = 40, max = 150 },
    Tooltip = "Dos manijas: elegís mínimo y máximo al mismo tiempo. Click en la barra mueve la manija más cercana; agarrar la manija por arriba o por abajo también debe funcionar" })

SNum:NumberStepper({ Texto = "Cantidad exacta", Flag = "v_step", Min = 1, Max = 999, Incremento = 1, Defecto = 10, Sufijo = " pcs",
    Tooltip = "Botones − / + con campo editable. Flechas ↑↓ con el campo enfocado. Los botones − y + deben verse grandes y el símbolo bien legible" })

SNum:NumberStepper({ Texto = "Decimal (paso 0.25)", Flag = "v_stepDec", Min = 0, Max = 10, Incremento = 0.25, Defecto = 1.5,
    Tooltip = "Incremento decimal: muestra automáticamente 2 decimales" })

-- ── Texto ───────────────────────────────────────────────────────
local STxt = TabCtrl:CrearSeccion("Campos de texto")
STxt:Parrafo({ Titulo = "Input / TagInput", Contenido = "Input libre, validado (número/patrón) o multilínea. TagInput genera chips con coma." })

STxt:Input({ Texto = "Nombre", Flag = "v_inNombre", Defecto = "", Placeholder = "Escribe tu nombre...",
    Tooltip = "Campo de texto libre, 1 línea" })

STxt:Input({ Texto = "Edad (1-99)", Flag = "v_inEdad", Tipo = "number", Min = 1, Max = 99, Defecto = "18",
    Tooltip = "Tipo='number': solo acepta números, los clampa a Min/Max" })

STxt:Input({ Texto = "Hex (patrón)", Flag = "v_inHex", Tipo = "pattern", Regex = "^%x+$",
    Placeholder = "solo 0-9 y A-F",
    Tooltip = "Tipo='pattern': valida contra el Regex al perder el foco" })

STxt:Input({ Texto = "Notas (multilínea)", Flag = "v_inNotas", Tipo = "textarea", Alto = 80, Defecto = "",
    Placeholder = "Escribe varias líneas...",
    Tooltip = "Tipo='textarea': caja multilínea con AutoScroll interno" })

STxt:TagInput({ Texto = "Ignorados", Flag = "v_tags", Defecto = { "Amigo1", "Amigo2" },
    Placeholder = "Nombre y Enter (o pegá a,b,c)...",
    MaxTags = 8,
    Tooltip = "Chips con ×: separador es la coma. Backspace con caja vacía borra el último" })

-- ── Selección ───────────────────────────────────────────────────
local SSel = TabCtrl:CrearSeccion("Selección")
SSel:Parrafo({ Titulo = "Dropdown / RadioGroup", Contenido = "Dropdown para listas largas (con buscador auto >8). RadioGroup para 2-4 opciones visibles en fila." })

SSel:Dropdown({ Texto = "Método", Flag = "v_ddSimple",
    Opciones = { "Tween", "CFrame", "Instant", "Safe Jump" }, Defecto = "Tween",
    Tooltip = "Dropdown simple: 4 opciones. Al desplegar: opciones altas, separadas y con el texto lejos del borde izquierdo. Con Micro-interacciones activo (sección Opciones), pasa el cursor por la cabecera: la flecha se aclara" })

SSel:Dropdown({ Texto = "Efectos (multi)", Flag = "v_ddMulti", Multi = true,
    Opciones = { "Fuego", "Hielo", "Veneno", "Rayo", "Tierra" }, Defecto = { "Fuego" },
    Tooltip = "Multi=true: cada opción es un checkbox. Get() devuelve una tabla" })

SSel:Dropdown({ Texto = "Arma (opciones ricas)", Flag = "v_ddRico",
    Opciones = {
        { Titulo = "Espada", Icono = "⚔️", Descripcion = "Rápida, poco daño" },
        { Titulo = "Hacha", Icono = "🪓", Descripcion = "Lenta, alto daño" },
        { Tipo = "Divider" },
        { Titulo = "Lanza", Icono = "🔱", Locked = true, LockedTitle = "Nivel 20" },
        "Arco",
    }, Defecto = "Espada",
    Tooltip = "Opciones con Icono, Descripcion, Locked y separadores" })

SSel:RadioGroup({ Texto = "Modo", Flag = "v_radio",
    Opciones = { "Farm", "PvP", "Raid" }, Defecto = "Farm",
    Tooltip = "RadioGroup: 3 opciones visibles, selección única" })

-- ── Especiales ──────────────────────────────────────────────────
local SEsp = TabCtrl:CrearSeccion("Controles especiales")
SEsp:Parrafo({ Titulo = "ColorPicker / Keybind", Contenido = "ColorPicker con sliders RGB + swatches + Hex. Keybind captura tecla del teclado (o gamepad/táctil adaptativo)." })

SEsp:ColorPicker({ Texto = "Color principal", Flag = "v_color",
    Defecto = Color3.fromRGB(90, 140, 210),
    Tooltip = "Click en la cabecera para desplegar los sliders RGB. Con Micro-interacciones activo, pasa el cursor por la cabecera: la muestra gana borde de acento" })

SEsp:ColorPicker({ Texto = "Color (estilo 2D)", Flag = "v_color2d", Estilo = "2D",
    Defecto = Color3.fromRGB(220, 90, 90),
    Tooltip = "Cuadrado de saturación/valor + barra de matiz. También acepta hex y muestras" })

SEsp:Keybind({ Texto = "Tecla de activación", Flag = "v_kbSimple",
    Defecto = Enum.KeyCode.E,
    Tooltip = "Click para capturar una nueva tecla" })

SEsp:Keybind({ Texto = "Combo con modificadores", Flag = "v_kbMods",
    ConModificadores = true, Defecto = { KeyCode = Enum.KeyCode.G, Ctrl = true, Shift = true, Alt = false },
    Tooltip = "Captura también Ctrl/Shift/Alt al asignar" })

-- Modos de tecla: Press (por defecto), Hold y Toggle.
SEsp:Keybind({ Texto = "Mantener para agacharse", Flag = "v_kbHold", Modo = "Hold",
    Defecto = Enum.KeyCode.C,
    Tooltip = "Hold: el Callback recibe true al presionar y false al soltar",
    Callback = function(presionada)
        AlanUI:Notificar({ Titulo = "Hold", Texto = presionada and "Tecla presionada" or "Tecla soltada", Duracion = 1 })
    end })

SEsp:Keybind({ Texto = "Alternar modo vuelo", Flag = "v_kbToggle", Modo = "Toggle",
    Defecto = Enum.KeyCode.V,
    Tooltip = "Toggle: cada pulsación alterna el estado. La tecla se guarda como siempre; el estado vive en el flag 'v_kbToggle_estado'",
    Callback = function(encendido)
        AlanUI:Notificar({ Titulo = "Toggle", Texto = encendido and "Vuelo ENCENDIDO" or "Vuelo APAGADO", Duracion = 1.2 })
    end })

SEsp:Boton({ Texto = "Ver estado del Toggle", Tooltip = "Lee el flag 'v_kbToggle_estado' (no se guarda en perfiles)",
    Callback = function()
        local estado = AlanUI:ObtenerFlag("v_kbToggle_estado")
        AlanUI:Notificar({ Titulo = "Estado del Toggle", Texto = tostring(estado), Duracion = 2 })
    end })

-- ── Visualización ──────────────────────────────────────────────
local SVis = TabCtrl:CrearSeccion("Visualización")
SVis:Parrafo({ Titulo = "Label / Progreso / Imagen", Contenido = "Elementos de solo lectura: Label (texto dinámico), Progreso (barra), Imagen (con Aspecto)." })

local lblSimple = SVis:Label({ Texto = "Label simple", Flag = "v_lbl", Valor = "valor inicial",
    Tooltip = "Set() para cambiar el valor, SetColor() para colorearlo" })

SVis:Label({ Texto = "Label con auto-update", Flag = "v_lblAuto", Valor = "–",
    Cada = 0.5, Actualizar = function() return string.format("%.1fs desde carga", os.clock()) end,
    Tooltip = "Actualiza su valor cada 0.5s automáticamente" })

SVis:Label({ Texto = "Label con descripción", Flag = "v_lblDesc", Valor = "ℹ️",
    Descripcion = "La flecha expande este texto. Útil para explicaciones largas sin ocupar espacio permanente.",
    Tooltip = "Click en la flecha de la izquierda para expandir" })

local prog = SVis:Progreso({ Texto = "Progreso", Flag = "v_prog", Defecto = 35,
    Tooltip = "Solo lectura. Set() con 0-100" })

SVis:Imagen({ Url = "rbxassetid://6031094678", Aspecto = "16:9", Radio = 8,
    Tooltip = "Imagen con Aspecto 16:9: la altura se calcula según el ancho" })

-- Botones para mover el Label simple y el Progreso
local SBotVar = TabCtrl:CrearSeccion("Variar valores")
SBotVar:Boton({ Texto = "Cambiar Label simple", Callback = function()
    local valores = { "estado óptimo", "cargando...", "error de red", "listo ✅" }
    local v = valores[math.random(1, #valores)]
    lblSimple:Set(v)
    lblSimple:SetColor(v:find("error") and Color3.fromRGB(231,76,60) or Color3.fromRGB(46,204,113))
end })

SBotVar:Boton({ Texto = "Avanzar Progreso +10%", Callback = function()
    local actual = AlanUI:ObtenerFlag("v_prog") or 0
    local nuevo = (actual + 10) % 110
    prog:Set(nuevo > 100 and 0 or nuevo)
end })

-- ══════════════════════════════════════════════════════════════
--  TAB 2 — VENTANA Y LAYOUT
-- ══════════════════════════════════════════════════════════════
local TabVent = V:CrearTab("Ventana", "@pestana")

-- ── Contenedores ───────────────────────────────────────────────
local SCont = TabVent:CrearSeccion("Contenedores de layout")
SCont:Parrafo({ Titulo = "Parrafo / Divider / Grupo", Contenido = "Elementos que agrupan o separan sin ser controles: texto informativo, líneas divisorias, botones en fila." })

SCont:Divider({ Texto = "Divider con texto" })
SCont:Parrafo({
    Titulo = "Parrafo simple",
    Contenido = "Solo título y contenido, sin extras.",
})

SCont:Parrafo({
    Titulo = "Parrafo avanzado",
    Contenido = "Con imagen, miniatura y botones abajo.",
    ImagenUrl = "rbxassetid://6031094678", ImagenAlto = 90,
    MiniaturaUrl = "rbxassetid://6031094678",
    Botones = {
        { Texto = "Copiar", Variante = "primary", Callback = function() AlanUI:Notificar({ Titulo = "Copiar", Texto = "Pulsado", Duracion = 1.5 }) end },
        { Texto = "Cerrar", Callback = function() AlanUI:Notificar({ Titulo = "Cerrar", Texto = "Pulsado", Duracion = 1.5 }) end },
    },
})

SCont:Divider({ Texto = "Grupo de botones (fila horizontal)" })
local grupo = SCont:Grupo()
grupo:Boton({ Texto = "Guardar", Callback = function() AlanUI:Notificar({ Titulo = "Guardar", Texto = "Pulsado", Duracion = 1.5 }) end })
grupo:Boton({ Texto = "Cargar", Callback = function() AlanUI:Notificar({ Titulo = "Cargar", Texto = "Pulsado", Duracion = 1.5 }) end })
grupo:Boton({ Texto = "Eliminar", Callback = function() AlanUI:Notificar({ Titulo = "Eliminar", Texto = "Pulsado", Tipo = "Warning", Duracion = 1.5 }) end })

SCont:Divider({ Texto = "Columnas (se apilan si no caben)" })
local colA, colB = SCont:Columnas({ MinimoAncho = 380 })
colA:Toggle({ Texto = "Opción A", Flag = "v_colA", Defecto = true,
    Tooltip = "Cada columna acepta los mismos controles que una sección" })
colA:Slider({ Texto = "Valor A", Flag = "v_colA2", Min = 0, Max = 100, Defecto = 40 })
colB:Toggle({ Texto = "Opción B", Flag = "v_colB" })
colB:Dropdown({ Texto = "Modo B", Flag = "v_colB2", Opciones = { "Uno", "Dos", "Tres" }, Defecto = "Uno" })

SCont:Divider()

-- ── Funciones de la ventana ────────────────────────────────────
local SFunc = TabVent:CrearSeccion("Funciones en vivo")
SFunc:Parrafo({ Titulo = "Control de la ventana", Contenido = "Cada botón ejecuta una función pública de la ventana." })

SFunc:Boton({ Texto = "🔍 Buscar 'color'", Tooltip = "Filtra por ese texto y cambia a la primera tab con match",
    Callback = function() V:Buscar("color") end })

SFunc:Boton({ Texto = "🔍 Limpiar búsqueda", Callback = function() V:Buscar("") end })

SFunc:Boton({ Texto = "📐 Alternar orientación (vertical ↔ horizontal)",
    Tooltip = "Cambia entre tabs laterales y barra superior",
    Callback = function()
        local horizontal = (V._buscadorBoxHoriz and V._buscadorBoxHoriz.Visible)
        V:CambiarOrientacion(horizontal and "vertical" or "horizontal")
    end })

SFunc:Boton({ Texto = "🎨 Aplicar tema DemoNeon", Callback = function() V:CambiarTema("DemoNeon") end })
SFunc:Boton({ Texto = "🎨 Aplicar tema Negro (default)", Callback = function() V:CambiarTema("Negro") end })

SFunc:Boton({ Texto = "➖ Minimizar (3s)", Callback = function()
    V:Minimizar()
    task.delay(3, function() V:Mostrar() end)
end })

SFunc:Boton({ Texto = "🔄 Resetear todos los controles a Defecto",
    Tooltip = "Vuelve los controles a su valor inicial (no toca la Preinstalada)",
    Callback = function() V:Resetear() end })


-- ── Posición de la ventana ─────────────────────────────────────
local SPos = TabVent:CrearSeccion("Posición de la ventana")
SPos:Parrafo({
    Titulo = "Se recuerda entre ejecuciones",
    Contenido = "Arrastra la ventana por la barra de título y vuelve a ejecutar la vitrina: aparece donde la dejaste. Se guarda en un archivo propio por script (AlanUI/Config/_ui). Al abrir y cerrar con la tecla de toggle vuelve a su posición de inicio, como siempre.",
})
SPos:Boton({ Texto = "🎯 Resetear posición",
    Tooltip = "Vuelve al centro de la pantalla (Ventana:ResetearPosicion)",
    Callback = function() V:ResetearPosicion() end })
SPos:Boton({ Texto = "💾 Guardar posición ahora",
    Tooltip = "Escribe la posición actual sin esperar (Ventana:GuardarPosicion). Devuelve false si el ejecutor no soporta archivos",
    Callback = function()
        local ok = V:GuardarPosicion()
        AlanUI:Notificar({ Titulo = "Posición", Texto = ok and "Guardada" or "No se pudo guardar (¿sin soporte de archivos?)",
            Tipo = ok and "Success" or "Warning", Duracion = 2 })
    end })
SPos:Boton({ Texto = "📂 Cargar posición guardada",
    Tooltip = "Mueve la ventana a la última posición guardada (Ventana:CargarPosicion)",
    Callback = function()
        local ok = V:CargarPosicion()
        AlanUI:Notificar({ Titulo = "Posición", Texto = ok and "Cargada" or "No hay una posición guardada",
            Tipo = ok and "Success" or "Info", Duracion = 2 })
    end })

-- ── Bordes de la ventana ───────────────────────────────────────
local SBorde = TabVent:CrearSeccion("Bordes de la ventana")
SBorde:Parrafo({
    Titulo = "Ventana:EstablecerBorde",
    Contenido = "Acepta lo mismo que un tag (colores, degradados, arcoíris, animación) y además los colores del tema, que siguen al tema si lo cambias. También se puede cambiar desde la Preinstalada, en Apariencia.",
})
local ESTILOS_BORDE = {
    { "🎨 Tema (degradado)", "tema",
      "Degradado Accent → AccentLight. Sigue al tema: pruébalo y cambia de tema" },
    { "🎞️ Tema animado", { Color = "tema", Animar = true, Grosor = 3 },
      "El mismo degradado, girando. El degradado se cierra sobre sí mismo para que la vuelta no tenga costura" },
    { "🌈 Arcoíris animado", "rainbow",
      "Como el tag rainbow: se anima solo" },
    { "💜 Degradado personalizado", { Color = { Color3.fromRGB(150, 90, 230), Color3.fromRGB(60, 190, 220) }, Animar = true, Grosor = 3 },
      "Dos colores tuyos, animado" },
    { "🔀 Mezcla tema + color", { Color = { "Accent", Color3.fromRGB(255, 90, 140), "AccentLight" }, Animar = true, Grosor = 3 },
      "Una lista puede mezclar Color3 con claves del tema ('Accent', 'AccentLight'...)" },
    { "🟡 Color liso", Color3.fromRGB(241, 196, 15),
      "Un Color3 suelto" },
    { "🧹 Quitar borde", nil,
      "Vuelve al borde de siempre (EstablecerBorde(nil))" },
}
for _, estilo in ipairs(ESTILOS_BORDE) do
    SBorde:Boton({ Texto = estilo[1], Tooltip = estilo[3], Callback = function()
        V:EstablecerBorde(estilo[2])
    end })
end

-- ── Construir desde schema ─────────────────────────────────────
local SSchema = TabVent:CrearSeccion("Construir desde schema")
SSchema:Parrafo({ Titulo = "ConstruirDesdeSchema", Contenido = "Crea una pestaña entera con secciones y controles desde una sola tabla." })

SSchema:Boton({ Texto = "🧬 Crear pestaña entera desde schema",
    Tooltip = "Crea una tab nueva con 2 secciones y varios controles preconfigurados",
    Callback = function()
        V:ConstruirDesdeSchema({
            Tabs = {{
                Nombre = "Generada", Icono = "🧬",
                Secciones = {
                    {
                        Nombre = "Creada dinámicamente",
                        Controles = {
                            { Control = "Toggle", Texto = "Auto Mode", Flag = "sch_auto", Defecto = false },
                            { Control = "Slider", Texto = "Velocidad", Flag = "sch_vel", Min = 0, Max = 100, Defecto = 30 },
                            { Control = "Boton", Texto = "Aplicar", Callback = function()
                                AlanUI:Notificar({ Titulo = "Schema", Texto = "Botón de schema pulsado", Duracion = 2 })
                            end },
                        },
                    },
                    {
                        Nombre = "Colapsada por defecto",
                        ColapsadaPorDefecto = true,
                        Controles = {
                            { Control = "Input", Texto = "API Key", Flag = "sch_api", Defecto = "" },
                        },
                    },
                },
            }},
        })
        AlanUI:Notificar({
            Titulo = "🧬 Schema construido",
            Texto = "Pestaña 'Generada' agregada. Slider guardado en sch_vel",
            Duracion = 4,
        })
    end })

-- ── Divisores dinámicos ────────────────────────────────────────
local SDiv = TabVent:CrearSeccion("Divisores")
SDiv:Parrafo({ Titulo = "Divisores", Contenido = "Divisor dentro de la página (entre secciones) y divisor en la barra lateral (entre tabs)." })

SDiv:Boton({ Texto = "📏 Crear Divisor de tab aquí", Tooltip = "Añade un separador al FINAL de esta pestaña y te lleva hasta él",
    Callback = function()
        TabVent:CrearDivisor({ Texto = "Fin de funciones en vivo" })
        -- El divisor entra al final de la página: se desplaza hasta ahí
        -- para que se vea aparecer (si no, queda fuera de pantalla).
        task.delay(0.15, function()
            local pagina = TabVent.Pagina
            game:GetService("TweenService"):Create(
                pagina,
                TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                { CanvasPosition = Vector2.new(0, pagina.AbsoluteCanvasSize.Y) }
            ):Play()
        end)
    end })

SDiv:Boton({ Texto = "📐 Crear Divisor de sidebar", Tooltip = "Añade una línea entre las tabs laterales",
    Callback = function() V:AgregarDivisorSidebar({ Texto = "Extras" }) end })

-- ── Destruir ───────────────────────────────────────────────────
local SDest = TabVent:CrearSeccion("Destruir")
SDest:Parrafo({ Titulo = "Ventana:Destruir()", Contenido = "Cierra la interfaz y limpia todas las conexiones. Pide confirmación antes de ejecutar." })

SDest:Boton({ Texto = "💀 Destruir la ventana",
    Tooltip = "Equivalente al botón ✕ de la barra superior",
    Callback = function()
        AlanUI:Confirmar({
            Titulo = "¿Cerrar la vitrina?",
            Contenido = "Todos los controles se perderán.",
            Icono = "⚠️",
            BotonAceptar = { Texto = "Cerrar", Variante = "danger", Callback = function() V:Destruir() end },
            BotonCancelar = { Texto = "Cancelar" },
        })
    end })

-- ══════════════════════════════════════════════════════════════
--  TAB 3 — ALERTAS
-- ══════════════════════════════════════════════════════════════
local TabAlert = V:CrearTab("Alertas", "@advertencia")

-- ── Notificaciones ─────────────────────────────────────────────
local SNot = TabAlert:CrearSeccion("Notificaciones")
SNot:Parrafo({ Titulo = "Notificar", Contenido = "Tipos: Info (acento del tema), Success, Warning, Error. Persistente no se autocierra. Prioridad salta la cola." })

SNot:Boton({ Texto = "ℹ️ Notificación Info", Callback = function()
    AlanUI:Notificar({ Titulo = "Info", Texto = "Mensaje informativo genérico", Tipo = "Info", Duracion = 3 })
end })

SNot:Boton({ Texto = "✅ Notificación Success", Callback = function()
    AlanUI:Notificar({ Titulo = "Éxito", Texto = "Operación completada", Tipo = "Success", Duracion = 3 })
end })

SNot:Boton({ Texto = "⚠️ Notificación Warning", Callback = function()
    AlanUI:Notificar({ Titulo = "Atención", Texto = "Esto puede ser lento", Tipo = "Warning", Duracion = 3 })
end })

SNot:Boton({ Texto = "❌ Notificación Error", Callback = function()
    AlanUI:Notificar({ Titulo = "Error", Texto = "Algo salió mal en la operación", Tipo = "Error", Duracion = 3 })
end })

SNot:Boton({ Texto = "📌 Notificación Persistente", Tooltip = "No se autocierra. Click para descartarla",
    Callback = function()
        AlanUI:Notificar({ Titulo = "Requiere acción", Texto = "Click en la tarjeta para descartar", Tipo = "Warning", Persistente = true })
    end })

SNot:Boton({ Texto = "🔴 8 notificaciones (prueba de cola)", Tooltip = "Las últimas 4 se encolan",
    Callback = function()
        for i = 1, 8 do
            AlanUI:Notificar({ Titulo = "Notif " .. i, Texto = "Mensaje " .. i, Duracion = 1.5 })
        end
    end })

SNot:Boton({ Texto = "🚨 Prioridad alta (salta la cola)", Tooltip = "Con la cola llena, salta adelante",
    Callback = function()
        for i = 1, 6 do AlanUI:Notificar({ Titulo = "Baja " .. i, Texto = "prioridad 0", Duracion = 2 }) end
        AlanUI:Notificar({ Titulo = "⚡ CRÍTICA", Texto = "Prioridad 5 — salta adelante", Tipo = "Error", Prioridad = 5, Duracion = 4 })
    end })

-- ── Modal Confirmar ────────────────────────────────────────────
local SMod = TabAlert:CrearSeccion("Modal Confirmar")
SMod:Parrafo({ Titulo = "Confirmar", Contenido = "Modal con botones personalizables. Variantes: primary (acento), danger (rojo), tertiary (borde), neutral (por defecto)." })

SMod:Boton({ Texto = "Modal simple (Aceptar / Cancelar)",
    Callback = function()
        AlanUI:Confirmar({
            Titulo = "¿Continuar?",
            Contenido = "Esta es la forma simple con dos botones por defecto.",
            BotonAceptar = { Texto = "Continuar", Callback = function()
                AlanUI:Notificar({ Titulo = "Confirmado", Texto = "Se pulsó Continuar", Tipo = "Success", Duracion = 2 })
            end },
            BotonCancelar = { Texto = "Cancelar" },
        })
    end })

SMod:Boton({ Texto = "Modal con icono y 3 botones (variantes)",
    Callback = function()
        AlanUI:Confirmar({
            Icono = "⚠️",
            Titulo = "¿Eliminar el perfil?",
            Contenido = "Cada botón usa una variante distinta para comparar estilos.",
            Botones = {
                { Texto = "Eliminar", Variante = "danger",  Callback = function() AlanUI:Notificar({ Titulo = "danger", Texto = "Botón rojo pulsado", Tipo = "Error", Duracion = 2 }) end },
                { Texto = "Guardar",  Variante = "primary", Callback = function() AlanUI:Notificar({ Titulo = "primary", Texto = "Botón acento pulsado", Duracion = 2 }) end },
                { Texto = "Cancelar", Variante = "tertiary", Callback = function() AlanUI:Notificar({ Titulo = "tertiary", Texto = "Botón con borde pulsado", Duracion = 2 }) end },
            },
        })
    end })

SMod:Boton({ Texto = "Modal apilado (dos encima)",
    Callback = function()
        AlanUI:Confirmar({
            Titulo = "Primer modal",
            Contenido = "Pulsa Siguiente para abrir otro encima.",
            BotonAceptar = { Texto = "Siguiente", Callback = function()
                AlanUI:Confirmar({ Titulo = "Segundo modal", Contenido = "Este quedó encima del primero." })
            end },
            BotonCancelar = { Texto = "Cerrar" },
        })
    end })

-- ── Dialogo por tipo ───────────────────────────────────────────
local SDlg = TabAlert:CrearSeccion("Dialogo (por tipo)")
SDlg:Parrafo({ Titulo = "AlanUI:Dialogo",
    Contenido = "Un modal que elige solo el ícono, el color del borde y el botón de aceptar según el Tipo: info, question, success, warning o error." })

local DIALOGOS_DEMO = {
    { Texto = "ℹ️ info",     Tipo = "info",     Titulo = "Información",       Contenido = "Un mensaje informativo con un solo botón." },
    { Texto = "❓ question", Tipo = "question", Titulo = "¿Guardar cambios?", Contenido = "Las preguntas traen Sí y Cancelar." },
    { Texto = "✅ success",  Tipo = "success",  Titulo = "Listo",             Contenido = "La operación terminó bien. Borde verde." },
    { Texto = "⚠️ warning",  Tipo = "warning",  Titulo = "Cuidado",           Contenido = "Las advertencias traen borde amarillo y Cancelar." },
    { Texto = "❌ error",    Tipo = "error",    Titulo = "Falló",             Contenido = "Los errores usan borde rojo y el botón de aceptar en rojo." },
}
for _, demo in ipairs(DIALOGOS_DEMO) do
    SDlg:Boton({ Texto = demo.Texto, Callback = function()
        AlanUI:Dialogo({ Tipo = demo.Tipo, Titulo = demo.Titulo, Contenido = demo.Contenido })
    end })
end

SDlg:Boton({ Texto = "☑️ Con casilla (\"No volver a preguntar\")",
    Tooltip = "El estado de la casilla llega a los Callback de los botones",
    Callback = function()
        AlanUI:Dialogo({
            Tipo = "question", Titulo = "¿Aplicar ahora?",
            Contenido = "Marca la casilla y elige un botón: su estado llega al Callback.",
            Casilla = { Texto = "No volver a preguntar" },
            Botones = {
                { Texto = "Después", Variante = "neutral", Callback = function(marcada)
                    AlanUI:Notificar({ Titulo = "Después", Texto = "Casilla: " .. tostring(marcada), Duracion = 2 })
                end },
                { Texto = "Aplicar", Variante = "primary", Callback = function(marcada)
                    AlanUI:Notificar({ Titulo = "Aplicar", Texto = "Casilla: " .. tostring(marcada), Tipo = "Success", Duracion = 2 })
                end },
            },
        })
    end })

SDlg:Boton({ Texto = "🎨 Ancho y borde propios",
    Tooltip = "Ancho (240-480) y ColorBorde también funcionan en AlanUI:Confirmar",
    Callback = function()
        AlanUI:Dialogo({
            Tipo = "info", Titulo = "Modal ancho", Ancho = 400,
            ColorBorde = Color3.fromRGB(150, 90, 230),
            Contenido = "Este modal mide 400 px de ancho y tiene un borde violeta.",
        })
    end })

SDlg:Boton({ Texto = "🌈 Borde degradado animado",
    Tooltip = "Los modales también aceptan 'Borde', con el mismo formato que EstablecerBorde",
    Callback = function()
        AlanUI:Dialogo({
            Tipo = "info", Titulo = "Borde con tema",
            Contenido = "Este modal usa Borde = { Color = { \"Accent\", \"AccentLight\" }, Animar = true } y sigue los colores de la interfaz.",
            Borde = { Color = { "Accent", "AccentLight" }, Animar = true, Grosor = 3 },
        })
    end })

-- ── Tags ───────────────────────────────────────────────────────
local STag = TabAlert:CrearSeccion("Tags del header")
STag:Parrafo({ Titulo = "AgregarTag", Contenido = "Pastillas junto al título. Colores predefinidos: info, success, warning, danger, neutral. También acepta Color3 o tabla de Color3." })

local tagsGuardados = {}
STag:Boton({ Texto = "➕ Agregar tag de cada color", Callback = function()
    for _, c in ipairs({ "info", "success", "warning", "danger", "neutral" }) do
        table.insert(tagsGuardados, V:AgregarTag({ Texto = c:upper(), Color = c }))
    end
end })

STag:Boton({ Texto = "🎨 Tag con Color3 custom", Callback = function()
    table.insert(tagsGuardados, V:AgregarTag({ Texto = "CUSTOM", Color = Color3.fromRGB(120, 80, 200) }))
end })

STag:Boton({ Texto = "🌈 Tag rainbow animado", Callback = function()
    table.insert(tagsGuardados, V:AgregarTag({ Texto = "RAINBOW", Color = "rainbow", Icono = "🌈" }))
end })

STag:Boton({ Texto = "🗑️ Quitar el último tag", Callback = function()
    local t = table.remove(tagsGuardados)
    if t then t.Remover() end
end })

-- ── Configurar un tag ──────────────────────────────────────────
local STagCfg = TabAlert:CrearSeccion("Configurar tag")
STagCfg:Parrafo({ Titulo = "Tag a tu medida",
    Contenido = "Elige el texto, el ícono, el color y si se anima. Luego agrégalo al header con el botón. Cada tag se quita con '🗑️ Quitar el último tag' de la sección de arriba." })

STagCfg:Input({ Texto = "Texto", Flag = "tagcfg_texto", Defecto = "MI TAG", Placeholder = "Texto del tag...",
    Tooltip = "Lo que dice la pastilla. Si lo dejas vacío se usa 'TAG'" })
STagCfg:Input({ Texto = "Ícono (opcional)", Flag = "tagcfg_icono", Defecto = "", Placeholder = "Un emoji, por ejemplo 🔥",
    Tooltip = "Emoji o carácter que va antes del texto" })
STagCfg:Dropdown({ Texto = "Color", Flag = "tagcfg_color",
    Opciones = { "info", "success", "warning", "danger", "neutral", "rainbow", "Color3 personalizado", "Degradado (2 colores)" },
    Defecto = "info",
    Tooltip = "Los 5 primeros son colores predefinidos. 'Color3 personalizado' usa el Color 1; 'Degradado' mezcla el Color 1 con el Color 2" })
STagCfg:ColorPicker({ Texto = "Color 1", Flag = "tagcfg_c1", Defecto = Color3.fromRGB(120, 80, 200),
    Tooltip = "Se usa con 'Color3 personalizado' y con 'Degradado'" })
STagCfg:ColorPicker({ Texto = "Color 2 (degradado)", Flag = "tagcfg_c2", Defecto = Color3.fromRGB(60, 190, 220),
    Tooltip = "Segundo color del degradado" })
STagCfg:Toggle({ Texto = "Animar", Flag = "tagcfg_animar", Defecto = true,
    Tooltip = "Hace girar el degradado (rainbow y degradado de 2 colores). En un color liso no se nota" })
STagCfg:Toggle({ Texto = "Clickeable", Flag = "tagcfg_click", Defecto = false,
    Tooltip = "Si está activo, al tocar el tag aparece una notificación" })

STagCfg:Boton({ Texto = "➕ Agregar tag con esta configuración",
    Tooltip = "Crea el tag en el header con los valores de arriba",
    Callback = function()
        local texto = AlanUI:ObtenerFlag("tagcfg_texto")
        if type(texto) ~= "string" or texto:gsub("%s", "") == "" then texto = "TAG" end

        local color = AlanUI:ObtenerFlag("tagcfg_color")
        if color == "Color3 personalizado" then
            color = AlanUI:ObtenerFlag("tagcfg_c1")
        elseif color == "Degradado (2 colores)" then
            color = { AlanUI:ObtenerFlag("tagcfg_c1"), AlanUI:ObtenerFlag("tagcfg_c2") }
        end

        local cfgTag = { Texto = texto, Color = color, Animar = AlanUI:ObtenerFlag("tagcfg_animar") == true }
        local icono = AlanUI:ObtenerFlag("tagcfg_icono")
        if type(icono) == "string" and icono ~= "" then cfgTag.Icono = icono end
        if AlanUI:ObtenerFlag("tagcfg_click") == true then
            cfgTag.Callback = function()
                AlanUI:Notificar({ Titulo = "🏷️ Tag tocado", Texto = texto, Duracion = 2 })
            end
        end
        table.insert(tagsGuardados, V:AgregarTag(cfgTag))
    end })

STagCfg:Boton({ Texto = "🧹 Quitar todos los tags", Callback = function()
    for i = #tagsGuardados, 1, -1 do
        local t = table.remove(tagsGuardados, i)
        if t then t.Remover() end
    end
end })

-- ══════════════════════════════════════════════════════════════
--  TAB 4 — ESTADOS
-- ══════════════════════════════════════════════════════════════
local TabEst = V:CrearTab("Estados", "@bloqueado")

-- ── Lock / Unlock ──────────────────────────────────────────────
local SLock = TabEst:CrearSeccion("Lock (bloqueo)")
SLock:Parrafo({ Titulo = "Lock / Unlock", Contenido = "El control queda cubierto por una capa con motivo visible. Set() sigue funcionando desde código." })

local controlesLockeables = {}
for _, par in ipairs({
    { "Boton",  { Texto = "Botón bloqueado", Callback = function() end } },
    { "Toggle", { Texto = "Toggle bloqueado", Flag = "lk_tog" } },
    { "Slider", { Texto = "Slider bloqueado", Flag = "lk_sl", Min = 0, Max = 100, Defecto = 50 } },
    { "Input",  { Texto = "Input bloqueado", Flag = "lk_in" } },
    { "Dropdown", { Texto = "Dropdown bloqueado", Flag = "lk_dd", Opciones = { "A", "B", "C" }, Defecto = "A" } },
}) do
    local nombre, cfg = par[1], par[2]
    cfg.Locked = true
    cfg.LockedTitle = "Requiere AutoFarm"
    controlesLockeables[nombre] = SLock[nombre](SLock, cfg)
end

SLock:Boton({ Texto = "🔓 Desbloquear todos", Callback = function()
    for _, c in pairs(controlesLockeables) do c:Unlock() end
end })

SLock:Boton({ Texto = "🔒 Volver a bloquear con otro motivo", Callback = function()
    for _, c in pairs(controlesLockeables) do c:Lock("Solo para premium") end
end })

-- ── Highlight ──────────────────────────────────────────────────
local SHL = TabEst:CrearSeccion("Highlight (resaltado)")
SHL:Parrafo({ Titulo = "Highlight", Contenido = "Borde pulsante temporal alrededor del control para llamar la atención." })

local sliderResaltable = SHL:Slider({ Texto = "Slider resaltable", Flag = "hl_sl", Min = 0, Max = 100, Defecto = 40 })

SHL:Boton({ Texto = "✨ Resaltar 2 segundos", Callback = function() sliderResaltable:Highlight(2) end })
SHL:Boton({ Texto = "✨ Resaltar 5 segundos", Callback = function() sliderResaltable:Highlight({ Duracion = 5 }) end })

-- ── VisibleSi ──────────────────────────────────────────────────
local SVis2 = TabEst:CrearSeccion("VisibleSi (visibilidad condicional)")
SVis2:Parrafo({ Titulo = "VisibleSi", Contenido = "El control se muestra/oculta según el valor de otro flag. Acá: los 3 siguientes se ocultan si 'Modo avanzado' está apagado." })

SVis2:Toggle({ Texto = "Modo avanzado", Flag = "vis_master", Defecto = true,
    Tooltip = "Prendé/apagá para ver los controles de abajo aparecer/desaparecer" })

SVis2:Slider({ Texto = "Precisión (avanzado)", Flag = "vis_prec", Min = 1, Max = 10, Defecto = 5,
    VisibleSi = function() return AlanUI.Flags["vis_master"] == true end })

SVis2:Dropdown({ Texto = "Prioridad (avanzado)", Flag = "vis_prio",
    Opciones = { "Baja", "Media", "Alta" }, Defecto = "Media",
    VisibleSi = function() return AlanUI.Flags["vis_master"] == true end })

SVis2:Input({ Texto = "Filtro (avanzado)", Flag = "vis_filtro", Placeholder = "…",
    VisibleSi = function() return AlanUI.Flags["vis_master"] == true end })

-- ══════════════════════════════════════════════════════════════
--  TAB 5 — APIs Y DIAGNÓSTICO
-- ══════════════════════════════════════════════════════════════
local TabAPI = V:CrearTab("APIs", "@diagnostico")

-- ── Historial ──────────────────────────────────────────────────
local SHist = TabAPI:CrearSeccion("Historial (Deshacer / Rehacer)")
SHist:Parrafo({ Titulo = "Historial", Contenido = "Registra los cambios de controles (no de la Preinstalada). Slider contiguos = 1 sola entrada." })

local lblHist = SHist:Label({ Texto = "Estado", Flag = "api_histEstado", Valor = "—" })
local grupoHist = SHist:Grupo()
grupoHist:Boton({ Texto = "↩️ Deshacer", Callback = function()
    local ok, entrada = AlanUI:Deshacer()
    AlanUI:Notificar({
        Titulo = ok and "↩️ Deshecho" or "Nada",
        Texto = ok and AlanUI:DescribirCambio(entrada) or "Nada que deshacer",
        Duracion = 2,
    })
end })
grupoHist:Boton({ Texto = "↪️ Rehacer", Callback = function()
    local ok, entrada = AlanUI:Rehacer()
    AlanUI:Notificar({
        Titulo = ok and "↪️ Rehecho" or "Nada",
        Texto = ok and AlanUI:DescribirCambio(entrada) or "Nada que rehacer",
        Duracion = 2,
    })
end })
SHist:Boton({ Texto = "🧹 Limpiar historial", Callback = function() AlanUI:LimpiarHistorial() end })

if conexionHistorial then conexionHistorial:Disconnect() end
conexionHistorial = AlanUI.Eventos.HistorialCambiado:Connect(function(nD, nR)
    pcall(function() lblHist:Set(nD .. " deshacer · " .. nR .. " rehacer") end)
end)

-- ── Perfiles ───────────────────────────────────────────────────
local SPerf = TabAPI:CrearSeccion("Perfiles de script")
SPerf:Parrafo({ Titulo = "SaveManager", Contenido = "Guarda/carga el estado de los controles (excepto la Preinstalada). Usa el prefijo 'v_' en los nombres de perfil demo." })

local perfilActual = "v_demo_1"

SPerf:Boton({ Texto = "💾 Guardar perfil actual (v_demo_1)", Callback = function()
    local ok = AlanUI.SaveManager:Guardar(perfilActual)
    AlanUI:Notificar({ Titulo = "Guardar", Texto = ok and ("Perfil " .. perfilActual .. " guardado") or "Falló", Duracion = 2 })
end })

SPerf:Boton({ Texto = "📂 Cargar perfil (v_demo_1)", Callback = function()
    AlanUI.SaveManager:Cargar(perfilActual)
end })

SPerf:Boton({ Texto = "🔀 Cambiar perfil activo (v_demo_2)", Tooltip = "Guarda el actual y carga/crea otro",
    Callback = function()
        AlanUI.SaveManager:CambiarPerfil(V, "v_demo_2")
        perfilActual = "v_demo_2"
    end })

SPerf:Boton({ Texto = "📋 Listar perfiles guardados", Callback = function()
    local lista = AlanUI.SaveManager:Listar()
    print("[VITRINA] Perfiles: " .. table.concat(lista, ", "))
    AlanUI:Notificar({ Titulo = "Listar", Texto = #lista .. " perfiles (ver consola)", Duracion = 3 })
end })

SPerf:Boton({ Texto = "📑 Duplicar v_demo_1 → v_demo_copia", Callback = function()
    local ok, err = AlanUI.SaveManager:Duplicar("v_demo_1", "v_demo_copia")
    AlanUI:Notificar({ Titulo = ok and "📑 Duplicado" or "Falló", Texto = ok and "v_demo_copia" or tostring(err), Duracion = 2 })
end })

SPerf:Boton({ Texto = "✏️ Renombrar v_demo_copia → v_demo_renombrado", Callback = function()
    local ok, err = AlanUI.SaveManager:Renombrar("v_demo_copia", "v_demo_renombrado")
    AlanUI:Notificar({ Titulo = ok and "✏️ Renombrado" or "Falló", Texto = ok and "v_demo_renombrado" or tostring(err), Duracion = 2 })
end })

SPerf:Boton({ Texto = "📤 Exportar v_demo_1 (copia al portapapeles)", Callback = function()
    local texto, copiado = AlanUI.SaveManager:Exportar("v_demo_1")
    if texto then
        AlanUI:Notificar({ Titulo = "📤 Exportado", Texto = copiado and "Copiado al portapapeles" or "Texto disponible", Duracion = 2 })
    else
        AlanUI:Notificar({ Titulo = "Falló", Texto = tostring(copiado), Tipo = "Error", Duracion = 3 })
    end
end })

SPerf:Boton({ Texto = "📥 Importar v_demo_1 → v_demo_importado", Callback = function()
    local texto = AlanUI.SaveManager:Exportar("v_demo_1")
    if not texto then AlanUI:Notificar({ Titulo = "Sin origen", Duracion = 2 }) return end
    local ok, err = AlanUI.SaveManager:Importar("v_demo_importado", texto)
    AlanUI:Notificar({ Titulo = ok and "📥 Importado" or "Falló", Texto = ok and "v_demo_importado" or tostring(err), Duracion = 2 })
end })

SPerf:Boton({ Texto = "🗑️ Limpiar todos los perfiles demo", Tooltip = "Borra v_demo_* del disco",
    Callback = function()
        local nombres = { "v_demo_1", "v_demo_2", "v_demo_copia", "v_demo_renombrado", "v_demo_importado" }
        for _, n in ipairs(nombres) do pcall(function() AlanUI.SaveManager:Eliminar(n) end) end
        AlanUI:Notificar({ Titulo = "Limpieza", Texto = "Perfiles demo eliminados", Duracion = 2 })
    end })

-- ── Lectura de flags ───────────────────────────────────────────
local SRead = TabAPI:CrearSeccion("Lectura de flags")
SRead:Parrafo({ Titulo = "ObtenerFlag / Try / ObtenerElemento", Contenido = "Tres formas de leer el valor de un control desde código." })

local lblLectura = SRead:Label({ Texto = "Resultado", Flag = "api_lecturaResultado", Valor = "—" })

SRead:Boton({ Texto = "📖 ObtenerFlag('v_slider')", Callback = function()
    local v = AlanUI:ObtenerFlag("v_slider")
    lblLectura:Set("ObtenerFlag v_slider = " .. tostring(v))
end })

SRead:Boton({ Texto = "📖 Try('no_existe', 999)", Callback = function()
    local v = AlanUI:Try("no_existe", 999)
    lblLectura:Set("Try no_existe = " .. tostring(v) .. " (fallback)")
end })

SRead:Boton({ Texto = "🔍 ObtenerElemento('v_slider').Get()", Callback = function()
    local elem = AlanUI:ObtenerElemento("v_slider")
    if elem then
        lblLectura:Set("Elemento.Get() = " .. tostring(elem.Get()))
    else
        lblLectura:Set("Elemento no encontrado")
    end
end })

SRead:Boton({ Texto = "✏️ AlanUI:ActualizarLabel('v_lbl', texto)", Callback = function()
    local nuevo = "actualizado " .. os.date("%H:%M:%S")
    AlanUI:ActualizarLabel("v_lbl", nuevo)
    lblLectura:Set("Label v_lbl → " .. nuevo)
end })

-- ── Diagnóstico ────────────────────────────────────────────────
local SDiag = TabAPI:CrearSeccion("Diagnóstico")
SDiag:Parrafo({ Titulo = "Diagnóstico", Contenido = "Herramientas para reportar bugs: Profiler, DiagnosticoCompleto, VerificarSoporte, ForzarTipo." })

SDiag:Boton({ Texto = "🩺 Profiler (una línea en consola)", Callback = function()
    AlanUI:Profiler()
end })

SDiag:Boton({ Texto = "🩺 DiagnosticoCompleto (dump a consola)", Callback = function()
    local d = AlanUI:DiagnosticoCompleto()
    print(string.format("[VITRINA] Entorno: %s · %s · Ejecutor: %s",
        d.Tipo, d.Plataforma, d.Ejecutor))
    print(string.format("[VITRINA] Features: %d/%d soportadas",
        d.FeaturesOk, d.FeaturesTotal))
    for _, adv in ipairs(d.Advertencias) do
        print(string.format("[VITRINA]   [%s] %s: %s", adv.nivel, adv.nombre, adv.mensaje))
    end
end })

SDiag:Boton({ Texto = "✅ Verificar soporte de 'Drawing'", Callback = function()
    local r = AlanUI:VerificarSoporte("Drawing")
    AlanUI:Notificar({
        Titulo = r.ok and "Drawing: soportado" or "Drawing: no soportado",
        Texto = r.ok and "Puedes usar Drawing.new()" or tostring(r.mensaje),
        Tipo = r.ok and "Success" or "Warning",
        Duracion = 3,
    })
end })

SDiag:Boton({ Texto = "🖥️ Forzar tipo = Tablet", Callback = function()
    AlanUI:ForzarTipo("Tablet")
    AlanUI:Notificar({ Titulo = "🖥️ Tipo forzado", Texto = "Ahora se comporta como Tablet", Duracion = 2 })
end })

SDiag:Boton({ Texto = "🖥️ Liberar tipo forzado (auto)", Callback = function()
    AlanUI:LiberarForzado()
    AlanUI:Notificar({ Titulo = "🖥️ Tipo auto", Texto = "Vuelve a detectar solo", Duracion = 2 })
end })

-- ── Opciones globales ──────────────────────────────────────────
local SOpc = TabAPI:CrearSeccion("Opciones globales (AlanUI.Opciones)")
SOpc:Parrafo({ Titulo = "Opciones", Contenido = "Valores que cambian el comportamiento de toda la librería sin pasarlos control por control." })
SOpc:Toggle({ Texto = "Confirmar al cerrar con la ✕", Flag = "v_opcConfirmarCierre", Defecto = AlanUI.Opciones.ConfirmarCierre ~= false,
    Tooltip = "AlanUI.Opciones.ConfirmarCierre. Apagado, la ✕ destruye la ventana sin preguntar. ¡Cuidado al probarlo!",
    Callback = function(v) AlanUI.Opciones.ConfirmarCierre = v end })
SOpc:Dropdown({ Texto = "Estilo de ColorPicker por defecto", Flag = "v_opcColorEstilo", Opciones = { "RGB", "2D" },
    Defecto = AlanUI.Opciones.ColorPickerEstiloPredeterminado or "RGB",
    Tooltip = "AlanUI.Opciones.ColorPickerEstiloPredeterminado. Afecta a los ColorPicker que se creen DESPUÉS (usa 'Estilo' para fijarlo en uno concreto)",
    Callback = function(v) AlanUI.Opciones.ColorPickerEstiloPredeterminado = v end })

SOpc:Toggle({ Texto = "Borde adaptativo", Flag = "v_opcBordeAdaptativo", Defecto = AlanUI.Opciones.BordeAdaptativo == true,
    Tooltip = "AlanUI.Opciones.BordeAdaptativo. Se aplica en el próximo cambio de tema (usa los botones de abajo). Apagado y cambiando de tema, los bordes vuelven a su transparencia original",
    Callback = function(v) AlanUI.Opciones.BordeAdaptativo = v end })
SOpc:Toggle({ Texto = "Micro-interacciones", Flag = "v_opcMicro", Defecto = AlanUI.Opciones.MicroInteracciones == true,
    Tooltip = "AlanUI.Opciones.MicroInteracciones. Con esto activo, la flecha del Dropdown y el borde de la muestra del ColorPicker reaccionan al hover de abajo",
    Callback = function(v) AlanUI.Opciones.MicroInteracciones = v end })
SOpc:Toggle({ Texto = "Click directo en barras (mouse)", Flag = "v_opcClickDirecto", Defecto = AlanUI.Opciones.ClickDirectoEnBarras ~= false,
    Tooltip = "AlanUI.Opciones.ClickDirectoEnBarras. Activo: un click sobre la barra de un Slider o RangeSlider mueve la manija ahí al instante. Apagado: hay que mover el cursor unos píxeles",
    Callback = function(v) AlanUI.Opciones.ClickDirectoEnBarras = v end })
SOpc:Toggle({ Texto = "Iconos propios", Flag = "v_opcIconosPropios", Defecto = AlanUI.Opciones.IconosPropios == true,
    Tooltip = "AlanUI.Opciones.IconosPropios. Cambia los iconos de los Dialogo() por tipo al instante (prueba con la pestaña Iconos). El icono de la pestaña Preinstalada solo cambia al re-ejecutar la vitrina",
    Callback = function(v) AlanUI.Opciones.IconosPropios = v end })
SOpc:Toggle({ Texto = "Atajos de historial (Ctrl+Z / Ctrl+Y)", Flag = "v_opcAtajosHist", Defecto = AlanUI.Opciones.AtajosHistorial,
    Tooltip = "AlanUI.Opciones.AtajosHistorial. Apagado, Ctrl+Z y Ctrl+Y no hacen nada (pruébalo con el interruptor «Atajos: cámbiame» de la pestaña Fugas y Mini)",
    Callback = function(v) AlanUI.Opciones.AtajosHistorial = v end })
SOpc:Toggle({ Texto = "Guardar la posición de la ventana", Flag = "v_opcGuardarPos", Defecto = AlanUI.Opciones.GuardarPosicionVentana,
    Tooltip = "AlanUI.Opciones.GuardarPosicionVentana: valor por defecto de CrearVentana({ GuardarPosicion }). Solo afecta a las ventanas que se creen después",
    Callback = function(v) AlanUI.Opciones.GuardarPosicionVentana = v end })
SOpc:Toggle({ Texto = "Precargar iconos", Flag = "v_opcPrecargarIconos", Defecto = AlanUI.Opciones.PrecargarIconos,
    Tooltip = "AlanUI.Opciones.PrecargarIconos. Apagado, los iconos se descargan al dibujarse por primera vez (pueden tardar al bajar rápido). Solo afecta a los iconos que se creen después",
    Callback = function(v) AlanUI.Opciones.PrecargarIconos = v end })
SOpc:Toggle({ Texto = "Transparencia también en los controles", Flag = "v_opcTranspCtrl", Defecto = AlanUI.Opciones.TransparenciaEnControles,
    Tooltip = "AlanUI.Opciones.TransparenciaEnControles. Sube «Transparencia de la ventana» en Preinstalada: con esto activo también se aclaran las filas y las barras de los sliders",
    Callback = function(v)
        AlanUI.Opciones.TransparenciaEnControles = v
        local el = AlanUI.Elementos["sys_transparencia"]
        if el then el.Set(el.Get(), true) end
    end })
SOpc:Dropdown({ Texto = "Animaciones de la interfaz", Flag = "v_opcAnimaciones", Opciones = { "fantasma", "tamano", "ninguna" },
    Defecto = AlanUI.Opciones.Animaciones,
    Tooltip = "AlanUI.Opciones.Animaciones. «fantasma»: la ventana se minimiza animando un marco liviano y los cambios de tamaño de contenedores pesados son instantáneos; «tamano»: se anima todo; «ninguna»: nada se anima (ni los bordes que giran). Prueba a minimizar, cambiar de pestaña y mover sliders en cada modo",
    Callback = function(v) AlanUI.Opciones.Animaciones = v end })
SOpc:Dropdown({ Texto = "Animación de la ventana", Flag = "v_opcAnimVentana", Opciones = { "auto", "fantasma", "tamano", "ninguna" },
    Defecto = AlanUI.Opciones.AnimacionVentana,
    Tooltip = "AlanUI.Opciones.AnimacionVentana: solo minimizar y mostrar. «auto» sigue a «Animaciones de la interfaz»; los demás lo fuerzan",
    Callback = function(v) AlanUI.Opciones.AnimacionVentana = v end })
SOpc:Toggle({ Texto = "Auto contraste del texto", Flag = "v_opcAutoContraste", Defecto = AlanUI.Opciones.AutoContraste,
    Tooltip = "AlanUI.Opciones.AutoContraste. Al aplicar un tema, el texto que no llegue a contraste 4.5:1 con los fondos pasa a blanco o negro. Cambia de tema para verlo",
    Callback = function(v) AlanUI.Opciones.AutoContraste = v end })
SOpc:Toggle({ Texto = "Indicador de guardado en la barra de título", Flag = "v_opcIndicadorGuardado", Defecto = AlanUI.Opciones.IndicadorGuardado,
    Tooltip = "AlanUI.Opciones.IndicadorGuardado. Un puntito en la barra de título: gris sin cambios, ámbar con cambios pendientes, verde recién guardado. Solo afecta a las ventanas que se creen después",
    Callback = function(v) AlanUI.Opciones.IndicadorGuardado = v end })
SOpc:Boton({ Texto = "☀️ Aplicar tema Blanco", Tooltip = "Tema claro: con Borde adaptativo activo, los bordes se ven más marcados. Para volver al oscuro: pestaña Ventana › Funciones en vivo › tema Negro",
    Callback = function() AlanUI.ThemeManager:AplicarTema("Blanco") end })

local SVerif = TabAPI:CrearSeccion("Verificación de cambios recientes")
SVerif:Parrafo({ Titulo = "Pruebas", Contenido = "Cada botón o control de esta sección comprueba un cambio de la librería. Los pasos están en el tooltip." })
SVerif:Boton({ Texto = "🔌 Contar conexiones registradas",
    Tooltip = "Cuenta las conexiones de la auto-limpieza. Escribe y sal de un campo de texto (Input) y vuelve a tocar: el número no debe bajar y las vivas deben ser casi todas",
    Callback = function()
        local activa = _G.AlanUI_InstanciaActiva
        local lista = activa and activa.Conexiones or {}
        local vivas = 0
        for _, c in ipairs(lista) do
            if c.Connected ~= false then vivas = vivas + 1 end
        end
        AlanUI:Notificar({ Titulo = "Conexiones", Texto = string.format("Registradas: %d | vivas: %d", #lista, vivas), Duracion = 3 })
    end })
SVerif:Toggle({ Texto = "Tooltip largo (prueba de bordes)", Flag = "v_verTooltipBordes", Defecto = false,
    Tooltip = "Arrastra la ventana hasta que este control quede pegado al borde inferior de la pantalla y toca el ?: el tooltip debe abrirse hacia arriba y verse completo. Luego pégalo al borde derecho: no debe salirse. Si queda más arriba y hay espacio, debe abrirse hacia abajo como siempre" })
SVerif:Boton({ Texto = "🔤 Diagnóstico de tamaños de texto (pestañas)",
    Tooltip = "Mide el texto de cada pestaña lateral y de @alanbeikersFFXD: tamaño aplicado, tamaño esperado, ancho disponible, ancho del texto y factor de escala. Lo guarda en AlanUI_Diagnostico_Texto.txt para pasármelo",
    Callback = function()
        local TextService = game:GetService("TextService")
        local raices = {}
        pcall(function() if gethui then raices[#raices + 1] = gethui() end end)
        pcall(function() raices[#raices + 1] = game:GetService("CoreGui") end)
        pcall(function() raices[#raices + 1] = game:GetService("Players").LocalPlayer.PlayerGui end)
        local nombres = { "Preinstalada", "Controles", "Ventana", "Alertas", "Estados", "APIs", "Benchmark", "alanbeikersFFXD" }
        local factorTexto = (tonumber(AlanUI.Opciones.EscalaTextoPredeterminada) or 100) / 100
        local piso = AlanUI.Capacidades.Teclado and 6 or 9
        local objetivo = math.max(piso, math.floor(12 * factorTexto + 0.5))
        local camara = workspace.CurrentCamera
        local lineas = {
            "=== Diagnóstico de texto | " .. os.date("%Y-%m-%d %H:%M:%S") .. " ===",
            string.format("version=%s | tactil=%s | escala_ui=%s | escala_texto=%s | objetivo_pestana=%d | piso=%d | pantalla=%s",
                tostring(AlanUI.Version), tostring(AlanUI.Capacidades.EsTactil),
                tostring(AlanUI.Opciones.EscalaInterfazPredeterminada), tostring(AlanUI.Opciones.EscalaTextoPredeterminada),
                objetivo, piso, camara and tostring(camara.ViewportSize) or "n/d"),
        }
        local vistos = {}
        for _, raiz in ipairs(raices) do
            local ok, desc = pcall(function() return raiz:GetDescendants() end)
            if ok then
                for _, o in ipairs(desc) do
                    if o:IsA("TextLabel") and not vistos[o] and o.AbsoluteSize.X > 0 then
                        for _, n in ipairs(nombres) do
                            if o.Text:find(n, 1, true) and #o.Text <= #n + 6 then
                                vistos[o] = true
                                local factor, a = 1, o
                                while a do
                                    local okSc, sc = pcall(function() return a:FindFirstChildOfClass("UIScale") end)
                                    if okSc and sc then factor = factor * sc.Scale end
                                    a = a.Parent
                                end
                                local function medir(tam)
                                    local okM, v = pcall(function() return TextService:GetTextSize(o.Text, tam, o.Font, Vector2.new(10000, 100)).X end)
                                    return okM and v or 0
                                end
                                local anchoUnidades = o.AbsoluteSize.X / factor
                                lineas[#lineas + 1] = string.format(
                                    "texto=%q | TextSize=%d | ancho_label_px=%.0f | factor_UIScale=%.3f | ancho_label_unidades=%.0f | ancho_texto_actual=%.0f | ancho_texto_objetivo=%.0f | cabe_objetivo_en_px=%s | cabe_objetivo_en_unidades=%s",
                                    o.Text, o.TextSize, o.AbsoluteSize.X, factor, anchoUnidades, medir(o.TextSize), medir(objetivo),
                                    tostring(medir(objetivo) <= o.AbsoluteSize.X), tostring(medir(objetivo) <= anchoUnidades))
                                break
                            end
                        end
                    end
                end
            end
        end
        lineas[#lineas + 1] = ""
        local texto = table.concat(lineas, "\n")
        print(texto)
        local guardado = pcall(function()
            local previo = (isfile and isfile("AlanUI_Diagnostico_Texto.txt")) and readfile("AlanUI_Diagnostico_Texto.txt") or ""
            writefile("AlanUI_Diagnostico_Texto.txt", previo .. texto .. "\n")
        end)
        AlanUI:Notificar({ Titulo = "Diagnóstico de texto", Texto = (#lineas - 3) .. " textos medidos. " .. (guardado and "Guardado en AlanUI_Diagnostico_Texto.txt" or "No se pudo guardar el archivo (ver consola)"), Duracion = 6 })
    end })
SVerif:Boton({ Texto = "📏 Texto de botón muy largo para que se ajuste a este ancho y no se corte",
    Tooltip = "Mueve el slider 'Tamaño de la interfaz' de Preinstalada: el texto debe achicarse hasta entrar, sin cortarse con '...' mientras sea posible",
    Callback = function() end })

SVerif:Boton({ Texto = "🪟 Abrir modal con texto largo", Tooltip = "El texto del modal no debe verse desacomodado al aparecer",
    Callback = function()
        AlanUI:Confirmar({ Titulo = "Modal de prueba", Contenido = "Este es un texto un poco largo para comprobar que al aparecer el modal el contenido ya está en su lugar y no se reacomoda.",
            BotonCancelar = { Texto = "Cancelar" }, BotonAceptar = { Texto = "Aceptar" } })
    end })

local TabBench = V:CrearTab("Benchmark", "@historial")
local SBench = TabBench:CrearSeccion("Estrés por tipo de control")
SBench:Parrafo({ Titulo = "Qué hace", Contenido = "Crea N controles de cada uno de los 18 tipos de AlanUI, uno tipo tras otro. Por cada tipo mide: creación (CPU con os.clock), estabilización (frames hasta volver a la normalidad), conexiones y memoria que suma, y estrés: una operación sobre todos sus controles en cada frame (Set o Lock/Unlock) y luego alternar el tema Blanco/Negro. Al final guarda todo en AlanUI_Benchmark_Tipos.txt. Los controles no se pueden borrar: solo se permite una corrida por ejecución de la vitrina. Termina con el tema Negro aplicado." })

local benchPorTipo = 51
SBench:Dropdown({ Texto = "Controles por tipo", Opciones = { "51", "75", "100" }, Defecto = "51",
    Tooltip = "51 por tipo x 18 tipos = 918 controles. Con 100 son 1800: puede congelar unos segundos",
    Callback = function(v) benchPorTipo = tonumber(v) or 51 end })

local benchCorriendo = false
local benchYaCorrio = false
local BENCH_ARCHIVO = "AlanUI_Benchmark_Tipos.txt"

local function benchEstadisticas(dts)
    local c = {}
    local suma = 0
    for i, v in ipairs(dts) do c[i] = v; suma = suma + v end
    table.sort(c)
    return suma / #c, c[math.ceil(#c / 2)], c[math.max(1, math.ceil(#c * 0.95))], c[#c]
end

local function benchFrames(n)
    local lista = {}
    for i = 1, n do lista[i] = game:GetService("RunService").Heartbeat:Wait() end
    return lista
end

local function benchMs(x) return string.format("%.1f", x * 1000) end

local function benchMemoriaMb()
    local ok, mb = pcall(function() return game:GetService("Stats"):GetTotalMemoryUsageMb() end)
    return ok and mb or 0
end

local function benchEjecutor()
    local ok, nombre = pcall(function()
        if identifyexecutor then return (identifyexecutor()) end
        if getexecutorname then return (getexecutorname()) end
    end)
    return ok and nombre or "desconocido"
end

local function benchConexiones()
    local activa = _G.AlanUI_InstanciaActiva
    local lista = activa and activa.Conexiones or {}
    local vivas = 0
    for _, c in ipairs(lista) do
        if c.Connected ~= false then vivas = vivas + 1 end
    end
    return #lista, vivas
end

local function benchGuardar(texto)
    return pcall(function()
        local previo = (isfile and isfile(BENCH_ARCHIVO)) and readfile(BENCH_ARCHIVO) or ""
        writefile(BENCH_ARCHIVO, previo .. texto .. "\n")
    end)
end

local BENCH_OPCIONES3 = { "Uno", "Dos", "Tres" }
local BENCH_TIPOS = {
    { "Boton", function(sec, i) return sec:Boton({ Texto = "Botón " .. i, Callback = function() end }) end,
        function(el, f) if f % 2 == 0 then el:Lock() else el:Unlock() end end },
    { "Toggle", function(sec, i) return sec:Toggle({ Texto = "Toggle " .. i, Defecto = false }) end,
        function(el, f) el:Set(f % 2 == 0) end },
    { "Casilla", function(sec, i) return sec:Casilla({ Texto = "Casilla " .. i, Defecto = false }) end,
        function(el, f) el:Set(f % 2 == 0) end },
    { "Slider", function(sec, i) return sec:Slider({ Texto = "Slider " .. i, Min = 0, Max = 100, Incremento = 1, Defecto = 50 }) end,
        function(el, f, i) el:Set((f * 7 + i * 13) % 100) end },
    { "RangeSlider", function(sec, i) return sec:RangeSlider({ Texto = "Rango " .. i, Min = 0, Max = 200, Incremento = 10, Defecto = { min = 40, max = 150 } }) end,
        function(el, f, i) el:Set({ min = (f * 3 + i) % 80, max = 100 + (f + i) % 100 }) end },
    { "NumberStepper", function(sec, i) return sec:NumberStepper({ Texto = "Stepper " .. i, Min = 0, Max = 100, Incremento = 1, Defecto = 10 }) end,
        function(el, f) el:Set(f % 100) end },
    { "Input", function(sec, i) return sec:Input({ Texto = "Input " .. i, Defecto = "" }) end,
        function(el, f) el:Set("t" .. f) end },
    { "TagInput", function(sec, i) return sec:TagInput({ Texto = "Tags " .. i, Defecto = { "A", "B" } }) end,
        function(el, f) el:Set({ "x" .. (f % 5), "y" }) end },
    { "Dropdown", function(sec, i) return sec:Dropdown({ Texto = "Dropdown " .. i, Opciones = BENCH_OPCIONES3, Defecto = "Uno" }) end,
        function(el, f) el:Set(BENCH_OPCIONES3[f % 3 + 1]) end },
    { "RadioGroup", function(sec, i) return sec:RadioGroup({ Texto = "Radio " .. i, Opciones = BENCH_OPCIONES3, Defecto = "Uno" }) end,
        function(el, f) el:Set(BENCH_OPCIONES3[f % 3 + 1]) end },
    { "ColorPicker", function(sec, i) return sec:ColorPicker({ Texto = "Color " .. i, Defecto = Color3.fromRGB(90, 140, 210) }) end,
        function(el, f, i) el:Set(Color3.fromHSV((f * 0.01 + i * 0.01) % 1, 0.6, 0.9)) end },
    { "Keybind", function(sec, i) return sec:Keybind({ Texto = "Tecla " .. i, Defecto = Enum.KeyCode.E }) end,
        function(el, f) el:Set(f % 2 == 0 and Enum.KeyCode.E or Enum.KeyCode.F) end },
    { "Label", function(sec, i) return sec:Label({ Texto = "Label " .. i, Valor = "valor" }) end,
        function(el, f) el:Set("v" .. f) end },
    { "Progreso", function(sec, i) return sec:Progreso({ Texto = "Progreso " .. i, Defecto = 35 }) end,
        function(el, f, i) el:Set((f + i) % 100) end },
    { "Parrafo", function(sec, i) return sec:Parrafo({ Titulo = "Párrafo " .. i, Contenido = "Texto de prueba para medir el costo de un párrafo con varias palabras." }) end, nil },
    { "Divider", function(sec, i) return sec:Divider({ Texto = "Divider " .. i }) end, nil },
    { "Imagen", function(sec, i) return sec:Imagen({ Url = "rbxassetid://6031094678", Aspecto = "16:9", Radio = 8 }) end, nil },
    { "Grupo", function(sec, i)
        local g = sec:Grupo()
        g:Boton({ Texto = "A", Callback = function() end })
        g:Boton({ Texto = "B", Callback = function() end })
        return g
    end, nil },
}

local function benchCorrer()
    if benchCorriendo then return end
    if benchYaCorrio then
        AlanUI:Notificar({ Titulo = "Benchmark", Texto = "Ya se ejecutó. Re-ejecuta la vitrina para una corrida limpia", Duracion = 4 })
        return
    end
    benchCorriendo, benchYaCorrio = true, true
    task.spawn(function()
        local RunService = game:GetService("RunService")
        local lineas = {}
        local resumen = {}
        local okGeneral, errGeneral = pcall(function()
            local _, dtBase = benchEstadisticas(benchFrames(60))
            local umbral = dtBase * 1.5 + 0.004
            local conexInicio = benchConexiones()
            local memoriaInicio = benchMemoriaMb()
            local inicioTotal = os.clock()
            local acumulados = 0

            lineas[#lineas + 1] = "=== Benchmark por tipos | " .. os.date("%Y-%m-%d %H:%M:%S") .. " ==="
            lineas[#lineas + 1] = string.format("version=%s | ejecutor=%s | tactil=%s | escala_ui=%s | escala_texto=%s",
                tostring(AlanUI.Version), benchEjecutor(), tostring(AlanUI.Capacidades.EsTactil),
                tostring(AlanUI.Opciones.EscalaInterfazPredeterminada), tostring(AlanUI.Opciones.EscalaTextoPredeterminada))
            lineas[#lineas + 1] = string.format("opciones: BordeAdaptativo=%s | MicroInteracciones=%s | ClickDirectoEnBarras=%s",
                tostring(AlanUI.Opciones.BordeAdaptativo), tostring(AlanUI.Opciones.MicroInteracciones), tostring(AlanUI.Opciones.ClickDirectoEnBarras))
            lineas[#lineas + 1] = string.format("por_tipo=%d | tipos=%d | base_frame_ms=%s | conexiones_al_inicio=%d | memoria_mb_inicio=%.1f",
                benchPorTipo, #BENCH_TIPOS, benchMs(dtBase), conexInicio, memoriaInicio)

            for indice, def in ipairs(BENCH_TIPOS) do
                local nombre, crear, operar = def[1], def[2], def[3]
                local okFase, errFase = pcall(function()
                    local conexA = benchConexiones()
                    local memA = benchMemoriaMb()
                    local seccion = TabBench:CrearSeccion(string.format("%02d · %s (%d)", indice, nombre, benchPorTipo))
                    local elementos = {}

                    local t0 = os.clock()
                    for i = 1, benchPorTipo do elementos[i] = crear(seccion, i) end
                    local tCrear = os.clock() - t0
                    acumulados = acumulados + benchPorTipo

                    local tEstab, framesEstab, estables = 0, 0, 0
                    while estables < 5 and tEstab < 5 do
                        local dt = RunService.Heartbeat:Wait()
                        tEstab = tEstab + dt
                        framesEstab = framesEstab + 1
                        if dt <= umbral then estables = estables + 1 else estables = 0 end
                    end
                    local conexB = benchConexiones()
                    local memB = benchMemoriaMb()

                    local opTexto = "sin_operacion"
                    local opCpu, fallos = 0, 0
                    if operar then
                        local dts = {}
                        for f = 1, 60 do
                            local c0 = os.clock()
                            for i, el in ipairs(elementos) do
                                if not pcall(operar, el, f, i) then fallos = fallos + 1 end
                            end
                            opCpu = opCpu + (os.clock() - c0)
                            dts[f] = RunService.Heartbeat:Wait()
                        end
                        local prom, _, p95, maximo = benchEstadisticas(dts)
                        opTexto = string.format("estres_op: prom=%s p95=%s max=%s ms | op_cpu_ms_frame=%s | fallos=%d",
                            benchMs(prom), benchMs(p95), benchMs(maximo), benchMs(opCpu / 60), fallos)
                    end

                    local dtsTema, temaCpu = {}, 0
                    for f = 1, 20 do
                        local c0 = os.clock()
                        pcall(function() AlanUI.ThemeManager:AplicarTema(f % 2 == 0 and "Negro" or "Blanco") end)
                        temaCpu = temaCpu + (os.clock() - c0)
                        dtsTema[f] = RunService.Heartbeat:Wait()
                    end
                    pcall(function() AlanUI.ThemeManager:AplicarTema("Negro") end)
                    local temaProm, _, temaP95, temaMax = benchEstadisticas(dtsTema)

                    lineas[#lineas + 1] = string.format(
                        "tipo=%s | n=%d | acumulados=%d | crear_cpu_ms=%s | por_control_ms=%s | estab_ms=%s estab_frames=%d | conexiones_delta=%d (%.1f por control) | mem_delta_mb=%.1f | %s | estres_tema: prom=%s p95=%s max=%s ms | tema_cpu_ms_frame=%s",
                        nombre, benchPorTipo, acumulados, benchMs(tCrear), benchMs(tCrear / benchPorTipo),
                        benchMs(tEstab), framesEstab, conexB - conexA, (conexB - conexA) / benchPorTipo, memB - memA,
                        opTexto, benchMs(temaProm), benchMs(temaP95), benchMs(temaMax), benchMs(temaCpu / 20))
                    resumen[#resumen + 1] = { nombre = nombre, porControl = tCrear / benchPorTipo, estab = tEstab }
                end)
                if not okFase then
                    lineas[#lineas + 1] = string.format("tipo=%s | ERROR: %s", nombre, tostring(errFase))
                end
                print(lineas[#lineas])
            end

            local conexFin, vivasFin = benchConexiones()
            table.sort(resumen, function(a2, b2) return a2.porControl > b2.porControl end)
            local top = {}
            for i = 1, math.min(5, #resumen) do
                top[i] = string.format("%s (%s ms/control)", resumen[i].nombre, benchMs(resumen[i].porControl))
            end
            lineas[#lineas + 1] = string.format("TOTAL: controles=%d | duracion_s=%.1f | conexiones_inicio=%d fin=%d vivas=%d | memoria_mb_inicio=%.1f fin=%.1f",
                acumulados, os.clock() - inicioTotal, conexInicio, conexFin, vivasFin, memoriaInicio, benchMemoriaMb())
            lineas[#lineas + 1] = "MAS_CAROS_AL_CREAR: " .. table.concat(top, ", ")
            lineas[#lineas + 1] = ""
        end)
        if not okGeneral then
            lineas[#lineas + 1] = "ERROR_GENERAL: " .. tostring(errGeneral)
            warn("[Benchmark] " .. tostring(errGeneral))
        end
        local guardado = benchGuardar(table.concat(lineas, "\n"))
        for _, l in ipairs(lineas) do print(l) end
        AlanUI:Notificar({
            Titulo = "Benchmark terminado",
            Texto = (guardado and ("Guardado en " .. BENCH_ARCHIVO) or "No se pudo guardar el archivo (ver consola)"),
            Duracion = 10,
        })
        benchCorriendo = false
    end)
end

SBench:Boton({ Texto = "📋 Copiar el archivo de resultados",
    Tooltip = "Copia al portapapeles el contenido de AlanUI_Benchmark_Tipos.txt, por si no puedes sacar el archivo de la carpeta del ejecutor",
    Callback = function()
        local ok, texto = pcall(function() return readfile(BENCH_ARCHIVO) end)
        if ok and texto and pcall(setclipboard, texto) then
            AlanUI:Notificar({ Titulo = "Benchmark", Texto = "Resultados copiados al portapapeles", Duracion = 3 })
        else
            AlanUI:Notificar({ Titulo = "Benchmark", Texto = "No hay archivo todavía o el ejecutor no permite copiar", Duracion = 4 })
        end
    end })
SBench:Boton({ Texto = "🗑️ Borrar el archivo de resultados",
    Tooltip = "Elimina AlanUI_Benchmark_Tipos.txt para empezar una serie limpia",
    Callback = function()
        local ok = pcall(function() delfile(BENCH_ARCHIVO) end)
        AlanUI:Notificar({ Titulo = "Benchmark", Texto = ok and "Archivo borrado" or "No había archivo o no se pudo borrar", Duracion = 3 })
    end })
SBench:Boton({ Texto = "▶ Correr estrés por tipo",
    Tooltip = "Deja el mouse quieto y la ventana visible: tarda un minuto o más y la interfaz se puede ver lenta mientras corre. Al terminar guarda AlanUI_Benchmark_Tipos.txt en la carpeta de trabajo del ejecutor",
    Callback = benchCorrer })

local TabIconos = V:CrearTab("Iconos", "@apariencia")
local SIconos = TabIconos:CrearSeccion("Diálogos con iconos propios")
SIconos:Parrafo({ Titulo = "Qué prueba", Contenido = "Cada botón abre un Dialogo() de un tipo. Con 'Iconos propios' activo (Opciones globales) el icono es una imagen del tema; apagado, es un emoji. Revisa también el icono de las pestañas: 'Iconos' usa @apariencia, 'Icono roto' prueba el respaldo con emoji y 'Sin icono' un nombre que no existe." })
for _, tipo in ipairs({ "info", "question", "success", "warning", "error" }) do
    SIconos:Boton({ Texto = "Dialogo: " .. tipo, Tooltip = "Abre un Dialogo de tipo '" .. tipo .. "'. El icono debe verse nítido y del color del texto del tema",
        Callback = function()
            AlanUI:Dialogo({ Tipo = tipo, Titulo = "Tipo " .. tipo, Contenido = "Prueba del icono de este tipo." })
        end })
end
SIconos:Boton({ Texto = "Confirmar con @perfiles", Tooltip = "Pasa Icono = \"@perfiles\" directo a Confirmar: debe mostrar la imagen de perfiles",
    Callback = function()
        AlanUI:Confirmar({ Titulo = "Icono por nombre", Contenido = "Este modal usa Icono = \"@perfiles\".", Icono = "@perfiles",
            BotonAceptar = { Texto = "Aceptar" }, BotonCancelar = { Texto = "Cancelar" } })
    end })
SIconos:Boton({ Texto = "Confirmar con @noexiste", Tooltip = "Un nombre que no existe: debe mostrar el símbolo de respaldo (▪), no el texto '@noexiste'",
    Callback = function()
        AlanUI:Confirmar({ Titulo = "Icono inexistente", Contenido = "Este modal usa Icono = \"@noexiste\".", Icono = "@noexiste",
            BotonAceptar = { Texto = "Aceptar" }, BotonCancelar = { Texto = "Cancelar" } })
    end })
local SIconosCambio = TabIconos:CrearSeccion("Tema y iconos")
SIconosCambio:Parrafo({ Titulo = "Tinte por tema", Contenido = "Los iconos con color propio se ven igual en todos los temas. Los que no lo tienen (minimizar, pestaña) toman el color del texto. Cambia al tema Blanco (Opciones globales) y comprueba que todos siguen visibles. Sube check.png y agrega check = { Id = ..., Respaldo = \"✔️\" } a AlanUI.Iconos para ver el tilde de las casillas como imagen." })
local SCat = TabIconos:CrearSeccion("@guardar Catálogo de iconos (26)")
SCat:Parrafo({ Titulo = "Cómo se ve cada uno", Contenido = "Cada botón usa Icono = \"@nombre\". Toca uno para ver su nombre. Cada icono tiene su propio color (verde para éxito y guardar, rojo para error y eliminar, etc.), se ve nítido y a la izquierda del texto. El título de esta sección también lleva icono (@guardar)." })
for _, nombre in ipairs({ "exito", "error", "advertencia", "info", "pregunta", "buscar", "bloqueado", "cerrar", "minimizar", "pestana",
    "preinstalada", "diagnostico", "apariencia", "configuracion", "perfiles", "historial", "atajos", "salud",
    "guardar", "cargar", "eliminar", "duplicar", "renombrar", "exportar", "importar", "refrescar" }) do
    SCat:Boton({ Texto = nombre, Icono = "@" .. nombre, Tooltip = "Icono @" .. nombre,
        Callback = function() AlanUI:Notificar({ Titulo = "Icono", Texto = "@" .. nombre, Duracion = 2 }) end })
end
V:CrearTab("Icono roto", "@prueba_rota")
V:CrearTab("Sin icono", "@noexiste")

-- ── CrearVentanaConSeguridad ───────────────────────────────────
local SSeg = TabAPI:CrearSeccion("CrearVentanaConSeguridad")
SSeg:Parrafo({
    Titulo = "Detección de otro script",
    Contenido = "Simula que otro script que usa AlanUI se ejecuta mientras esta ventana está abierta. Aparece un modal preguntando si quieres reemplazarla.",
})

SSeg:Boton({ Texto = "🛡️ Simular segundo script",
    Tooltip = "Aparece el modal de detección. Si dices 'Sí', esta ventana se cierra y se abre la nueva",
    Callback = function()
        task.spawn(function()
            local ok, resultado = pcall(function()
                return AlanUI:CrearVentanaConSeguridad({
                    Titulo = "Segundo Script",
                    Subtitulo = "Prueba de detección",
                    -- Mismo tamaño que la vitrina: la ventana nueva nace como la
                    -- primera vez que se lanzó la interfaz (mismo tamaño base y,
                    -- por lo tanto, misma escala automática en pantalla).
                    TamanoX = TAMANO_X,
                    TamanoY = TAMANO_Y,
                    AutoGuardar = false,
                    NombreConfig = "vitrina_segundo",
                })
            end)

            if not ok then
                AlanUI:Notificar({ Titulo = "Error", Texto = tostring(resultado), Tipo = "Error", Duracion = 4 })
                return
            end

            if resultado == nil then
                -- El usuario eligió "No": la vitrina sigue viva.
                print("[VITRINA] Usuario eligió NO reemplazar. Ventana original preservada.")
                return
            end

            -- El usuario eligió "Sí": la vitrina fue destruida.
            -- Poblamos la nueva ventana con info.
            local tab = resultado:CrearTab("Info", "@info")
            local sec = tab:CrearSeccion("Segundo script activo")
            sec:Parrafo({
                Titulo = "Ventana reemplazada",
                Contenido = "Este es el segundo script corriendo.\nLa vitrina original fue destruida.",
            })
            sec:Boton({ Texto = "Cerrar segundo script", Callback = function()
                resultado:Destruir()
            end })
        end)
    end })

-- ══════════════════════════════════════════════════════════════
--  TAB — FUGAS, AVISOS Y MINI
--  Verifica: Profiler(true), DiagnosticoCompleto(true), aviso de Flags
--  duplicadas, Opciones.ModoDev, y la API del modo Mini / módulos
--  de la Preinstalada. Los tests de avisos se autoverifican
--  capturando el warn() de la libreria.
-- ══════════════════════════════════════════════════════════════
local TabFugas = V:CrearTab("Fugas y Mini", "@salud")

-- ── Correr prueba: ejecuta todas las pruebas automáticas y guarda un reporte ──
local hookVeredicto = nil
local PRUEBAS_REGISTRADAS = {}
local RUTA_REPORTE = "AlanUI_Vitrina_Reporte.txt"
local PRUEBAS_EXTRA = {
    "🔁 Flag duplicada", "🔤 ModoDev", "🔤 Aviso de Set", "📨 Tope de la cola",
    "🔕 CargarSilencioso con sinNotificar",
}

local function esPruebaAutomatica(texto)
    if type(texto) ~= "string" then return false end
    if texto:find("(manual)", 1, true) or texto:find("cierra esta ventana", 1, true) then return false end
    if texto:find("✔", 1, true) == 1 then return true end
    for _, inicio in ipairs(PRUEBAS_EXTRA) do
        if texto:find(inicio, 1, true) == 1 then return true end
    end
    return false
end

local SCorrer = TabFugas:CrearSeccion("Correr prueba")
SCorrer:Parrafo({ Titulo = "Todas las pruebas de una vez",
    Contenido = "Corre las pruebas automáticas de esta pestaña (no el Benchmark ni las manuales) y guarda el resultado en «" .. RUTA_REPORTE .. "», que también se copia al portapapeles. Si algo falla, pásame ese archivo. Tarda uno o dos minutos. Durante la corrida verás abrirse y cerrarse ventanas: cada prueba que necesita una ventana la crea, y la librería admite una a la vez, así que reemplaza a la vitrina. Es normal. Al terminar, la vitrina se reconstruye sola con la misma librería (no se vuelve a cargar) y vuelve a esta pestaña." })

local corriendoPruebas = false
SCorrer:Boton({ Texto = "▶ Correr prueba",
    Tooltip = "Ejecuta una por una las pruebas automáticas, junta los fallos y los errores de consola y los guarda en " .. RUTA_REPORTE,
    Callback = function()
        if corriendoPruebas then return end
        corriendoPruebas = true
        task.spawn(function()
            local resultados, erroresConsola = {}, {}
            local conLog = game:GetService("LogService").MessageOut:Connect(function(mensaje, tipo)
                if tipo == Enum.MessageType.MessageError then erroresConsola[#erroresConsola + 1] = mensaje end
            end)
            local actual
            local okTodo, errTodo = pcall(function()
                hookVeredicto = function(titulo, aprobo, detalle)
                    resultados[#resultados + 1] = { prueba = actual and actual.texto or "?", nombre = titulo, ok = aprobo == true, detalle = detalle }
                end
                local lista = {}
                for _, p in ipairs(PRUEBAS_REGISTRADAS) do
                    if esPruebaAutomatica(p.texto) then lista[#lista + 1] = p end
                end
                for i, prueba in ipairs(lista) do
                    actual = prueba
                    AlanUI:Notificar({ Id = "vt_runner", Titulo = ("Probando %d/%d"):format(i, #lista), Texto = prueba.texto, Duracion = 3 })
                    local antes = #resultados
                    local okLlamada, err = pcall(prueba.callback)
                    if not okLlamada then
                        resultados[#resultados + 1] = { prueba = prueba.texto, nombre = prueba.texto, ok = false, detalle = "error al ejecutar: " .. tostring(err) }
                    else
                        local limite = os.clock() + 25
                        while #resultados == antes and os.clock() < limite do task.wait(0.2) end
                        if #resultados == antes then
                            resultados[#resultados + 1] = { prueba = prueba.texto, nombre = prueba.texto, ok = false, detalle = "sin veredicto en 25 s (mira los errores de consola de este reporte)" }
                        end
                    end
                    task.wait(0.6)
                end
            end)
            hookVeredicto = nil
            task.wait(0.5)
            conLog:Disconnect()

            local correctas, fallos = 0, {}
            for _, r in ipairs(resultados) do
                if r.ok then correctas = correctas + 1 else fallos[#fallos + 1] = r end
            end
            local lineas = {}
            local function a(texto) lineas[#lineas + 1] = texto end
            a("=== Reporte de pruebas de la vitrina ===")
            a("Fecha: " .. os.date("%Y-%m-%d %H:%M:%S"))
            a("AlanUI: " .. tostring(AlanUI.Version))
            local okEj, ejecutor = pcall(function() return identifyexecutor() end)
            a("Ejecutor: " .. (okEj and tostring(ejecutor) or "desconocido"))
            a("Carga: " .. CARGA.Metodo .. (CARGA.Desarrollo and " (modo desarrollo: no es la carga publicada)" or ""))
            a(("Resultado: %d pruebas · %d correctas · %d con fallo"):format(#resultados, correctas, #fallos))
            if not okTodo then a("ERROR DEL EJECUTOR DE PRUEBAS: " .. tostring(errTodo)) end
            a("")
            a("-- FALLOS --")
            if #fallos == 0 then a("ninguno") end
            for _, r in ipairs(fallos) do
                a("✖ " .. tostring(r.nombre) .. " — " .. tostring(r.detalle))
                a("   (botón: " .. tostring(r.prueba) .. ")")
            end
            a("")
            a(("-- ERRORES DE CONSOLA DURANTE LA PRUEBA (%d) --"):format(#erroresConsola))
            for i = 1, math.min(#erroresConsola, 40) do a(erroresConsola[i]) end
            a("")
            a("-- ERRORES INTERNOS DE ALANUI --")
            local internos = AlanUI:ObtenerErrores()
            if #internos == 0 then a("ninguno") end
            for i = math.max(1, #internos - 29), #internos do
                a(("[%s] %s: %s"):format(os.date("%H:%M:%S", internos[i].Momento), tostring(internos[i].Contexto), tostring(internos[i].Mensaje)))
            end
            a("")
            a("-- AVISOS (últimos 15) --")
            local avisos = AlanUI:ObtenerErrores("aviso")
            if #avisos == 0 then a("ninguno") end
            for i = math.max(1, #avisos - 14), #avisos do
                a(("[%s] %s: %s"):format(os.date("%H:%M:%S", avisos[i].Momento), tostring(avisos[i].Contexto), tostring(avisos[i].Mensaje)))
            end
            a("")
            a("-- TODAS LAS PRUEBAS --")
            for _, r in ipairs(resultados) do
                a((r.ok and "✔ " or "✖ ") .. tostring(r.nombre) .. (r.detalle and (" — " .. tostring(r.detalle)) or ""))
            end
            a("")
            local okDiag, diag = pcall(function() return AlanUI:DiagnosticoCompleto(true) end)
            if okDiag and type(diag) == "table" and diag.Reporte then a(diag.Reporte) end

            local texto = table.concat(lineas, "\n")
            local guardado = type(writefile) == "function" and pcall(writefile, RUTA_REPORTE, texto)
            local copiado = type(setclipboard) == "function" and pcall(setclipboard, texto)
            if not guardado then print(texto) end
            corriendoPruebas = false
            task.wait(1)
            local okReconstruir, nueva = pcall(construirVitrina, false)
            if okReconstruir and type(nueva) == "table" and nueva.TabFugas then
                pcall(nueva.TabFugas.Seleccionar)
            end
            task.wait(0.5)
            AlanUI:Notificar({
                Titulo = ((#fallos == 0 and okTodo) and "✔ " or "✖ ") .. ("%d/%d pruebas correctas"):format(correctas, #resultados),
                Texto = (guardado and ("Reporte en " .. RUTA_REPORTE .. (copiado and " (copiado)" or "")) or "El reporte quedó en la consola")
                    .. (okReconstruir and "" or " · no se pudo reconstruir la vitrina: " .. tostring(nueva)),
                Tipo = (#fallos == 0 and okTodo) and "Success" or "Error", Duracion = 12,
            })
        end)
    end })

local crearSeccionOriginal = TabFugas.CrearSeccion
pcall(function()
    TabFugas.CrearSeccion = function(self, ...)
        local seccion = crearSeccionOriginal(self, ...)
        local botonOriginal = seccion.Boton
        pcall(function()
            seccion.Boton = function(this, cfg, ...)
                if type(cfg) == "table" and type(cfg.Callback) == "function" then
                    PRUEBAS_REGISTRADAS[#PRUEBAS_REGISTRADAS + 1] = { texto = cfg.Texto, callback = cfg.Callback }
                end
                return botonOriginal(this, cfg, ...)
            end
        end)
        return seccion
    end
end)

-- Captura lo que la libreria imprime con warn() mientras corre fn.
local function capturarWarn(fn)
    local G = (getgenv and getgenv()) or _G
    local original = G.warn
    local capturadas = {}
    G.warn = function(...)
        local partes = {}
        for i = 1, select("#", ...) do partes[i] = tostring((select(i, ...))) end
        table.insert(capturadas, table.concat(partes, " "))
    end
    local ok, err = pcall(fn)
    G.warn = original
    return capturadas, ok, err
end

local function algunaContiene(lista, ...)
    local trozos = { ... }
    for _, linea in ipairs(lista) do
        local todas = true
        for _, t in ipairs(trozos) do
            if not linea:find(t, 1, true) then todas = false break end
        end
        if todas then return true end
    end
    return false
end

local function veredicto(titulo, aprobo, detalle)
    print(string.format("[VITRINA] %s %s%s", aprobo and "✔" or "✖", titulo, detalle and (" — " .. detalle) or ""))
    if hookVeredicto then hookVeredicto(titulo, aprobo, detalle) return end
    AlanUI:Notificar({
        Titulo = (aprobo and "✔ " or "✖ ") .. titulo, Texto = detalle or (aprobo and "Correcto" or "Falló"),
        Tipo = aprobo and "Success" or "Error", Duracion = 5,
    })
end

-- ── Profiler(true) y DiagnosticoCompleto(true) ─────────────────
local SPerf = TabFugas:CrearSeccion("Profiler y reporte")
SPerf:Parrafo({ Titulo = "Profiler(true)", Contenido = "Compara los contadores con la última vez que lo llamaste (la primera guarda la línea base). Reporta crecimiento, no fugas: un aumento puede ser legítimo si creaste controles a propósito." })
SPerf:Boton({ Texto = "🩺 Profiler(true): comparar con la lectura anterior",
    Tooltip = "Primera pulsación: línea base. Siguientes: cuánto creció cada contador. Sin parámetro, Profiler() sigue siendo la foto de siempre",
    Callback = function()
        local d = AlanUI:Profiler(true)
        AlanUI:Notificar({ Titulo = "Profiler(true)", Duracion = 6,
            Texto = d.Comparacion.Detalle .. " · getconnections: " .. (d.Comparacion.GlobalesDisponibles and "disponible" or "NO disponible") })
        print(("[VITRINA] Profiler(true): GlobalesDisponibles = %s"):format(tostring(d.Comparacion.GlobalesDisponibles)))
    end })
SPerf:Boton({ Texto = "🧮 Contar instancias por clase",
    Tooltip = "Cuenta los objetos de la interfaz por clase (UICorner, TextLabel, UIGradient...). Lo copia al portapapeles o lo imprime en consola",
    Callback = function()
        local datosPerfil = AlanUI:Profiler({ PorClase = true })
        local conteo, total = datosPerfil.PorClase or {}, datosPerfil.ObjetosGui
        local filas = {}
        for clase, n in pairs(conteo) do filas[#filas + 1] = { clase, n } end
        table.sort(filas, function(a, b) return a[2] > b[2] end)
        local partes = {}
        for _, f in ipairs(filas) do partes[#partes + 1] = f[1] .. " " .. f[2] end
        local texto = ("Instancias de la interfaz: %d\n%s"):format(total, table.concat(partes, "\n"))
        local copiado = type(setclipboard) == "function" and pcall(setclipboard, texto)
        if not copiado then print("[VITRINA] " .. texto) end
        local top = {}
        for i = 1, math.min(6, #filas) do top[i] = filas[i][1] .. " " .. filas[i][2] end
        AlanUI:Notificar({ Titulo = ("Instancias: %d"):format(total), Texto = table.concat(top, " · ") .. (copiado and " (copiado)" or " (en consola)"), Duracion = 8 })
    end })

-- ── Avisos automáticos al crear controles ──────────────────────
local SAvisos = TabFugas:CrearSeccion("Avisos al crear controles")
SAvisos:Parrafo({ Titulo = "Qué prueba", Contenido = "Cada botón crea controles de prueba en la sección de abajo (no se pueden borrar) y revisa que la librería avise por warn() lo que corresponde. Corre una vez por ejecución de la vitrina." })
local SAvisosPrueba = TabFugas:CrearSeccion("Controles de prueba de avisos")
SAvisosPrueba:Parrafo({ Titulo = "Vacía al inicio", Contenido = "Los controles aparecen aquí al pulsar los botones de la sección anterior." })

local avisoDupCorrio, avisoDevCorrio = false, false
SAvisos:Boton({ Texto = "🔁 Flag duplicada y derivada del Texto → aviso automático",
    Tooltip = "Crea dos Toggle con la misma Flag (el primero deja de ser accesible) y dos Toggle sin Flag y con el mismo Texto (ambos usarían el Texto como Flag): cada caso debe dar un warn. Siempre activo, no depende de ModoDev",
    Callback = function()
        if avisoDupCorrio then
            AlanUI:Notificar({ Titulo = "Flag duplicada", Texto = "Ya se corrió. Re-ejecuta la vitrina para repetir", Duracion = 4 })
            return
        end
        avisoDupCorrio = true
        local capt, ok, err = capturarWarn(function()
            SAvisosPrueba:Toggle({ Texto = "Toggle original", Flag = "vit_flag_dup", Defecto = false })
            SAvisosPrueba:Toggle({ Texto = "Toggle duplicado", Flag = "vit_flag_dup", Defecto = false })
        end)
        local elemento = AlanUI:ObtenerElemento("vit_flag_dup")
        local captDerivada = capturarWarn(function()
            SAvisosPrueba:Toggle({ Texto = "Toggle sin Flag (derivada)", Defecto = false })
            SAvisosPrueba:Toggle({ Texto = "Toggle sin Flag (derivada)", Defecto = false })
        end)
        if not ok then
            veredicto("Flag duplicada", false, "error al crear: " .. tostring(err))
        elseif #capt == 0 or #captDerivada == 0 then
            veredicto("Flag duplicada", false, "no se capturó ningún warn (¿tu ejecutor aísla warn? mira la consola)")
        else
            local dupOk = algunaContiene(capt, "vit_flag_dup", "ya la usa otro control") and elemento ~= nil
            local derOk = algunaContiene(captDerivada, "no tiene Flag", "Toggle sin Flag (derivada)")
            veredicto("Flag duplicada", dupOk and derOk,
                ("duplicada: el control sigue funcionando y se avisó: %s · derivada del Texto avisa: %s"):format(tostring(dupOk), tostring(derOk)))
        end
    end })

SAvisos:Boton({ Texto = "🔤 ModoDev: aviso de typos (Defaut → Defecto)",
    Tooltip = "Con Opciones.ModoDev = true, una clave mal escrita avisa y sugiere la correcta; una clave válida no avisa; con ModoDev en false no se revisa nada",
    Callback = function()
        if avisoDevCorrio then
            AlanUI:Notificar({ Titulo = "ModoDev", Texto = "Ya se corrió. Re-ejecuta la vitrina para repetir", Duracion = 4 })
            return
        end
        avisoDevCorrio = true
        local previo = AlanUI.Opciones.ModoDev
        AlanUI.Opciones.ModoDev = true
        local conTypo = capturarWarn(function()
            SAvisosPrueba:Toggle({ Texto = "Con typo", Flag = "vit_typo", Defaut = true, Callbak = function() end })
        end)
        local sinTypo = capturarWarn(function()
            SAvisosPrueba:Toggle({ Texto = "Sin typo", Flag = "vit_sintypo", Defecto = true, Tooltip = "ok" })
        end)
        AlanUI.Opciones.ModoDev = false
        local apagado = capturarWarn(function()
            SAvisosPrueba:Toggle({ Texto = "Typo con ModoDev apagado", Flag = "vit_typo_off", Defaut = true })
        end)
        AlanUI.Opciones.ModoDev = previo

        local sugiere  = algunaContiene(conTypo, "Defaut", "Defecto")
        local sugiere2 = algunaContiene(conTypo, "Callbak", "Callback")
        local sinFalso = not algunaContiene(sinTypo, "clave desconocida")
        local callado  = AlanUI.DebugMode == true or not algunaContiene(apagado, "clave desconocida")
        if #conTypo == 0 and #sinTypo == 0 then
            veredicto("ModoDev", false, "no se capturó ningún warn (¿tu ejecutor aísla warn? mira la consola)")
        else
            veredicto("ModoDev", sugiere and sugiere2 and sinFalso and callado,
                ("sugiere Defaut→Defecto: %s · Callbak→Callback: %s · sin falsos positivos: %s · apagado no avisa: %s")
                    :format(tostring(sugiere), tostring(sugiere2), tostring(sinFalso), tostring(callado)))
        end
    end })

-- Cantidad de conexiones vivas a UserInputService.InputChanged (nil si el
-- ejecutor no expone getconnections). Es la que usa el arrastre de la libreria.
local function conexionesInputChanged()
    if type(getconnections) ~= "function" then return nil end
    local ok, n = pcall(function() return #getconnections(game:GetService("UserInputService").InputChanged) end)
    return ok and n or nil
end

-- ── Sufijo dinámico, Placeholder, ObtenerOpciones, aviso Multi y cola ──
local SNuevo = TabFugas:CrearSeccion("Sufijo dinámico, Placeholder y ObtenerOpciones")
SNuevo:Slider({ Texto = "Distancia (Sufijo función)", Flag = "vn_dist", Min = 0, Max = 2000, Incremento = 10, Defecto = 500,
    Tooltip = "Debe mostrar «500 m» y pasar a «km» al llegar a 1000. Escribe «1500 km» o «300 m» en la caja: se interpreta bien",
    Sufijo = function(v) return v >= 1000 and " km" or " m" end })
SNuevo:RangeSlider({ Texto = "Rango (Sufijo función)", Flag = "vn_rango", Min = 0, Max = 2000, Incremento = 10, Defecto = { min = 200, max = 1500 },
    Tooltip = "Cada extremo lleva su propio sufijo: «200 m – 1500 km»",
    Sufijo = function(v) return v >= 1000 and " km" or " m" end })
SNuevo:Slider({ Texto = "Sufijo string (como siempre)", Flag = "vn_pct", Min = 0, Max = 100, Defecto = 40, Sufijo = "%" })
local ddPlaceholder = SNuevo:Dropdown({ Texto = "Arma", Flag = "vn_arma", Opciones = { "Espada", "Arco", "Hacha" },
    Placeholder = "Selecciona un arma...", Tooltip = "Sin selección debe decir «Arma: Selecciona un arma...» en vez de «Ninguno»" })
SNuevo:Dropdown({ Texto = "Sin Placeholder", Flag = "vn_sinph", Opciones = { "A", "B" },
    Tooltip = "Sin Placeholder sigue diciendo «Ninguno», como siempre" })
local ddMulti = SNuevo:Dropdown({ Texto = "Multi con Placeholder", Flag = "vn_multi", Multi = true, Opciones = { "Espada", "Arco", "Hacha" },
    Placeholder = "Ninguna elegida" })

SNuevo:Boton({ Texto = "✔ ObtenerOpciones() devuelve una copia",
    Callback = function()
        local a = ddPlaceholder.ObtenerOpciones()
        local original = #a
        table.insert(a, "Intruso"); a[1] = "Cambiada"        -- mutar la copia no debe afectar al control
        local b = ddPlaceholder.ObtenerOpciones()
        veredicto("ObtenerOpciones", original == 3 and #b == 3 and b[1] == "Espada" and b[3] == "Hacha",
            ("3 opciones, la copia mutada no afecta al control: %s"):format(tostring(#b == 3 and b[1] == "Espada")))
    end })
SNuevo:Boton({ Texto = "🔤 Aviso de Set en Multi (Modo Dev): lista y opciones inexistentes",
    Tooltip = "Con ModoDev = true: Set({\"Espada\"}) avisa que Multi espera { Opcion = true }; Set({ Hacha = true, Lanza = true }) avisa de «Lanza». No filtra nada",
    Callback = function()
        local previo = AlanUI.Opciones.ModoDev
        AlanUI.Opciones.ModoDev = true
        local capt = capturarWarn(function()
            ddMulti:Set({ "Espada" })
            ddMulti:Set({ Hacha = true, Lanza = true })
        end)
        local apagado
        AlanUI.Opciones.ModoDev = false
        apagado = capturarWarn(function() ddMulti:Set({ Lanza = true }) end)
        AlanUI.Opciones.ModoDev = previo
        ddMulti:Set({}) -- deja el control vacio
        local lista = algunaContiene(capt, "lista")
        local inexistente = algunaContiene(capt, "Lanza")
        local callado = AlanUI.DebugMode == true or #apagado == 0
        if #capt == 0 then
            veredicto("Aviso de Set en Multi", false, "no se capturó ningún warn (¿tu ejecutor aísla warn? mira la consola)")
        else
            veredicto("Aviso de Set en Multi", lista and inexistente and callado,
                ("avisa lista: %s · avisa opción inexistente: %s · sin ModoDev no avisa: %s"):format(tostring(lista), tostring(inexistente), tostring(callado)))
        end
    end })
SNuevo:Boton({ Texto = "📨 Tope de la cola de notificaciones",
    Tooltip = "Con MaxColaNotificaciones = 3 lanza 30 notificaciones seguidas: la cola no pasa de 3 esperando y sale UN solo aviso de tope. Después restaura la opción",
    Callback = function()
        local previo = AlanUI.Opciones.MaxColaNotificaciones
        AlanUI.Opciones.MaxColaNotificaciones = 3
        local capt = capturarWarn(function()
            for i = 1, 30 do
                AlanUI:Notificar({ Titulo = "Cola " .. i, Texto = "prueba de tope", Duracion = 1.5, Prioridad = (i == 30) and 5 or 0 })
            end
        end)
        AlanUI.Opciones.MaxColaNotificaciones = previo
        local avisosTope = 0
        for _, l in ipairs(capt) do if l:find("tope", 1, true) then avisosTope = avisosTope + 1 end end
        veredicto("Tope de la cola", avisosTope == 1,
            ("avisos de tope: %d (debe ser 1). Deberían verse solo unas pocas, y «Cola 30» (prioridad alta) entre las que esperaban"):format(avisosTope))
    end })

-- ── Test de fugas (destruye y recrea la ventana 5 veces) ───────
local SFugas = TabFugas:CrearSeccion("Test de fugas")
SFugas:Parrafo({ Titulo = "Qué hace", Contenido = "Crea una ventana de prueba con 50 controles (midiendo el tiempo con os.clock), la destruye y repite 5 veces. Después de cada creación llama a Profiler(true): desde el segundo ciclo, ningún contador debería crecer. Después de cada Destruir() comprueba que NO quede nada (y al final prueba la doble destrucción): registro vacío, cero conexiones, hilos, dibujos, instancias y objetos GUI, y (si tu ejecutor tiene getconnections) que la conexión global de arrastre se haya soltado. Esta ventana se cierra: al terminar queda una ventana con el resultado. Re-ejecuta la vitrina para volver." })

local function correrTestFugas()
    task.spawn(function()
        local CICLOS, CONTROLES = 5, 50
        local filas, crecimientos, tiempos, restosAlCerrar = {}, {}, {}, {}
        for i = 1, CICLOS do
            local W = AlanUI:CrearVentana({
                Titulo = ("Test de fugas %d/%d"):format(i, CICLOS), TamanoX = TAMANO_X, TamanoY = TAMANO_Y,
                AutoGuardar = false, NombreConfig = "vitrina_fugas",
            })
            local t0 = os.clock()
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            for n = 1, CONTROLES do sec:Toggle({ Texto = "Toggle " .. n, Defecto = false }) end
            tiempos[i] = (os.clock() - t0) * 1000
            task.wait(2) -- deja terminar la pantalla de carga y las animaciones de entrada
            local d = AlanUI:Profiler(true)
            if i > 1 and d.Comparacion.HayCrecimiento then
                table.insert(crecimientos, ("ciclo %d: %s"):format(i, d.Comparacion.Detalle))
            end
            filas[i] = ("Ciclo %d — crear %d controles: %.1f ms · Conexiones %d · Hilos %d · Instancias %d · ObjetosGUI %d%s"):format(
                i, CONTROLES, tiempos[i], d.Conexiones, d.Hilos, d.Instancias, d.ObjetosGui,
                (i > 1 and d.Comparacion.DeltaMemoriaMb) and (" · Δmem %+d MB"):format(d.Comparacion.DeltaMemoriaMb) or "")
            local abierta = conexionesInputChanged()
            W:Destruir()
            task.wait(0.4)
            local post = AlanUI:Profiler()
            local cerrada = conexionesInputChanged()
            local restos = {}
            if _G.AlanUI_InstanciaActiva ~= nil then table.insert(restos, "el registro de instancia sigue activo") end
            for _, campo in ipairs({ "Conexiones", "Hilos", "Dibujos", "Instancias", "ObjetosGui", "Elementos" }) do
                if (post[campo] or 0) ~= 0 then table.insert(restos, campo .. " = " .. tostring(post[campo])) end
            end
            if abierta and cerrada and cerrada >= abierta then
                table.insert(restos, ("InputChanged global no bajó (%d → %d)"):format(abierta, cerrada))
            end
            if #restos > 0 then table.insert(restosAlCerrar, ("ciclo %d: %s"):format(i, table.concat(restos, "; "))) end
            task.wait(0.1)
        end

        -- Doble destruccion: Destruir() dos veces no debe dar error ni
        -- desconectar dos veces, y destruir una ventana VIEJA cuando ya existe
        -- una nueva no debe tocar los registros de la viva.
        do
            local function nueva(titulo, flag)
                local W = AlanUI:CrearVentana({ Titulo = titulo, TamanoX = TAMANO_X, TamanoY = TAMANO_Y, AutoGuardar = false, NombreConfig = "vitrina_doble" })
                W:CrearTab("Prueba", "@info"):CrearSeccion("Controles"):Toggle({ Texto = "Toggle", Flag = flag, Defecto = false })
                return W
            end
            local A = nueva("Doble A", "dd_a")
            local B = nueva("Doble B", "dd_b") -- reemplaza a A
            task.wait(2)
            local okVieja, errVieja = pcall(function() A:Destruir() end)
            if not okVieja then table.insert(restosAlCerrar, "Destruir() de la ventana vieja dio error: " .. tostring(errVieja)) end
            if AlanUI:ObtenerElemento("dd_b") == nil then table.insert(restosAlCerrar, "destruir la ventana vieja borro los elementos de la ventana viva") end
            if AlanUI:Profiler().ObjetosGui == 0 then table.insert(restosAlCerrar, "destruir la ventana vieja destruyo la GUI de la viva") end
            local ok1, err1 = pcall(function() B:Destruir() end)
            local ok2, err2 = pcall(function() B:Destruir() end)
            if not ok1 or not ok2 then table.insert(restosAlCerrar, "Destruir() doble dio error: " .. tostring(err1 or err2)) end
            task.wait(0.4)
            local post = AlanUI:Profiler()
            if _G.AlanUI_InstanciaActiva ~= nil or post.Conexiones ~= 0 or post.Hilos ~= 0 or post.ObjetosGui ~= 0 then
                table.insert(restosAlCerrar, ("tras la doble destruccion quedaron restos: Conexiones %d, Hilos %d, ObjetosGUI %d"):format(post.Conexiones, post.Hilos, post.ObjetosGui))
            end
            table.insert(filas, "Doble destrucción: Destruir() x2 y destrucción de ventana vieja con otra viva — " .. ((#restosAlCerrar == 0) and "OK" or "ver problemas"))
        end

        local sinCrecimiento = #crecimientos == 0 and #restosAlCerrar == 0
        local resumen = sinCrecimiento and "✔ SIN CRECIMIENTO entre los ciclos 2 y 5 y NADA queda vivo al cerrar."
            or ("✖ PROBLEMAS detectados:\n" .. table.concat(crecimientos, "\n")
                .. ((#crecimientos > 0 and #restosAlCerrar > 0) and "\n" or "")
                .. table.concat(restosAlCerrar, "\n"))
        local texto = resumen .. "\n\n" .. table.concat(filas, "\n")
        print("[VITRINA] Test de fugas\n" .. texto)

        local R = AlanUI:CrearVentana({
            Titulo = "Resultado: test de fugas", TamanoX = TAMANO_X, TamanoY = TAMANO_Y,
            AutoGuardar = false, NombreConfig = "vitrina_fugas_resultado",
        })
        local s = R:CrearTab("Resultado", "@info"):CrearSeccion("Test de fugas")
        s:Parrafo({ Titulo = sinCrecimiento and "Todo limpio" or "Hay problemas", Contenido = texto })
        s:Boton({ Texto = "📋 Copiar resultado", Callback = function()
            AlanUI:Notificar({ Titulo = "Test de fugas", Texto = pcall(setclipboard, texto) and "Copiado" or "Tu ejecutor no permite copiar: está en la consola", Duracion = 3 })
        end })
        s:Boton({ Texto = "Cerrar", Callback = function() R:Destruir() end })
        veredicto("Test de fugas y cierre limpio", sinCrecimiento, sinCrecimiento and "Sin crecimiento y sin restos al cerrar (5 ciclos)" or "Mira la ventana de resultado")
    end)
end

SFugas:Boton({ Texto = "🔬 Correr test de fugas (cierra esta ventana)",
    Tooltip = "Tarda ~15 segundos. Destruye esta ventana, crea y destruye 5 ventanas de prueba y muestra el resultado",
    Callback = function()
        AlanUI:Confirmar({
            Titulo = "¿Correr el test de fugas?",
            Contenido = "La vitrina se cierra. Al terminar queda una ventana con el resultado; re-ejecuta la vitrina para volver.",
            Icono = "⚠️",
            BotonAceptar = { Texto = "Correr", Callback = correrTestFugas },
            BotonCancelar = { Texto = "Cancelar" },
        })
    end })

-- ── SoloAlSoltar, Callback por opción, Id de notificación, BloqueadoSi y tema Neón ──
local SRonda = TabFugas:CrearSeccion("SoloAlSoltar, Id, BloqueadoSi y más")

-- SoloAlSoltar (prueba visual: arrastrar no se puede simular desde código)
local contadorNormal, contadorSoltar, contadorRango = 0, 0, 0
local lblContadores = SRonda:Label({ Texto = "Callbacks recibidos", Flag = "vr_contadores", Valor = "normal 0 · soltar 0 · rango 0" })
local function refrescarContadores() lblContadores:Set(("normal %d · soltar %d · rango %d"):format(contadorNormal, contadorSoltar, contadorRango)) end
SRonda:Slider({ Texto = "Slider normal", Flag = "vr_normal", Min = 0, Max = 100, Defecto = 10,
    Tooltip = "Arrastra: el contador «normal» sube en cada cambio de valor",
    Callback = function() contadorNormal = contadorNormal + 1 refrescarContadores() end })
SRonda:Slider({ Texto = "Slider SoloAlSoltar", Flag = "vr_soltar", Min = 0, Max = 100, Defecto = 10, SoloAlSoltar = true,
    Tooltip = "Arrastra: el valor y el texto suben en vivo, pero el contador «soltar» sube UNA sola vez al soltar la barra",
    Callback = function() contadorSoltar = contadorSoltar + 1 refrescarContadores() end })
SRonda:RangeSlider({ Texto = "RangeSlider SoloAlSoltar", Flag = "vr_rango", Min = 0, Max = 100, Defecto = { min = 20, max = 80 }, SoloAlSoltar = true,
    Tooltip = "Igual que el slider: el contador «rango» sube una vez por gesto, al soltar",
    Callback = function() contadorRango = contadorRango + 1 refrescarContadores() end })

-- Callback por opcion del Dropdown
SRonda:Dropdown({ Texto = "Acción (Callback por opción)", Flag = "vr_accion", Opciones = {
        { Titulo = "Curar",  Descripcion = "Callback propio", Callback = function(op, marcada) AlanUI:Notificar({ Titulo = "Opción: " .. op, Texto = "marcada = " .. tostring(marcada), Duracion = 2, Tipo = "Success" }) end },
        { Titulo = "Atacar", Descripcion = "Callback propio", Callback = function(op) AlanUI:Notificar({ Titulo = "Opción: " .. op, Texto = "se ejecuta después del Callback general", Duracion = 2, Tipo = "Warning" }) end },
        "Sin callback propio",
    },
    Placeholder = "Elige una acción...",
    Tooltip = "Cada opción puede traer su propio Callback; se ejecuta DESPUÉS del Callback general. «Sin callback propio» no hace nada extra",
    Callback = function(v) print("[VITRINA] Callback general del Dropdown:", v) end })

-- Id de notificacion
SRonda:Boton({ Texto = "📨 Notificar 5 veces con el mismo Id",
    Tooltip = "Debe verse UNA sola tarjeta cuyo texto avanza de 1/5 a 5/5 y reinicia su temporizador, no cinco tarjetas apiladas",
    Callback = function()
        for i = 1, 5 do
            AlanUI:Notificar({ Id = "vit_progreso", Titulo = "Descarga", Texto = ("Paso %d/5"):format(i), Duracion = 3 })
            task.wait(0.4)
        end
    end, Async = true })
SRonda:Boton({ Texto = "📨 Notificar 3 veces SIN Id",
    Tooltip = "Sin Id todo funciona como siempre: tres tarjetas",
    Callback = function() for i = 1, 3 do AlanUI:Notificar({ Titulo = "Sin Id", Texto = "Tarjeta " .. i, Duracion = 3 }) end end })
SRonda:Parrafo({ Titulo = "Pausa al pasar el cursor", Contenido = "Con el estilo moderno y mouse, una notificación se detiene mientras el cursor está encima y sigue al salir (la franja de color se frena y se reanuda). En táctil y en estilo clásico no hay pausa." })

-- BloqueadoSi (autoverificado)
SRonda:Toggle({ Texto = "Bloquear los controles de abajo", Flag = "vr_bloq", Defecto = false })
local sliderBloq = SRonda:Slider({ Texto = "Se bloquea con el toggle", Flag = "vr_slider_bloq", Min = 0, Max = 100, Defecto = 50,
    BloqueadoSi = function() return AlanUI.Flags["vr_bloq"] == true end, BloqueadoMotivo = "Desactiva el toggle",
    Tooltip = "BloqueadoSi bloquea el control mientras la condición sea verdadera; se re-evalúa solo cuando cambia un Flag" })
local toggleBloq = SRonda:Toggle({ Texto = "Nace bloqueado y sigue bloqueado", Flag = "vr_locked_fijo", Defecto = false, Locked = true, LockedTitle = "Fijo",
    BloqueadoSi = function() return AlanUI.Flags["vr_bloq"] == true end })
SRonda:Boton({ Texto = "✔ BloqueadoSi: bloquea, desbloquea y respeta Locked",
    Callback = function()
        local elem = AlanUI.Elementos["vr_bloq"]
        elem.Set(true); task.wait(0.3)
        local bloqueado = sliderBloq.IsLocked and sliderBloq.IsLocked()
        elem.Set(false); task.wait(0.3)
        local desbloqueado = sliderBloq.IsLocked and not sliderBloq.IsLocked()
        local fijo = toggleBloq.IsLocked and toggleBloq.IsLocked() -- Locked = true no se desbloquea por BloqueadoSi
        veredicto("BloqueadoSi", bloqueado and desbloqueado and fijo,
            ("bloquea: %s · desbloquea: %s · respeta Locked de nacimiento: %s"):format(tostring(bloqueado), tostring(desbloqueado), tostring(fijo)))
    end })

-- ── Auditoría: Set con dos puntos, Flag derivada del Texto y registros que se compactan ──
local SAudit = TabFugas:CrearSeccion("Auditoría: registro y Set")
SAudit:Parrafo({ Titulo = "Qué prueba", Contenido = "Correcciones de la auditoría de código: ObtenerElemento(flag) acepta Set con punto y con dos puntos; dos controles sin Flag y con el mismo Texto avisan; y los registros de conexiones e hilos descartan lo que ya terminó para no crecer sin límite." })

SAudit:Boton({ Texto = "✔ ObtenerElemento(flag): Set con punto y con dos puntos",
    Tooltip = "Usa el slider «Sufijo string» de arriba (Flag vn_pct): elem.Set(v), elem:Set(v) y elem.Set(v, true) deben funcionar igual",
    Callback = function()
        local elem = AlanUI:ObtenerElemento("vn_pct")
        if not elem then veredicto("Set con dos puntos", false, "no existe el control vn_pct") return end
        local ok1 = pcall(function() elem.Set(31) end)
        local v1 = elem.Get()
        local ok2 = pcall(function() elem:Set(57) end)
        local v2 = elem.Get()
        local ok3 = pcall(function() elem:Set(64, true) end)
        local v3 = elem.Get()
        elem.Set(40)
        veredicto("Set con dos puntos", ok1 and ok2 and ok3 and v1 == 31 and v2 == 57 and v3 == 64,
            ("punto: %s · dos puntos: %s · dos puntos con 2º argumento: %s"):format(tostring(ok1 and v1 == 31), tostring(ok2 and v2 == 57), tostring(ok3 and v3 == 64)))
    end })

SAudit:Boton({ Texto = "✔ Los registros de conexiones e hilos se compactan",
    Tooltip = "Registra 300 conexiones y 200 hilos que ya terminaron: el registro no debe crecer en esa cantidad (se descartan las muertas cada 64 altas)",
    Callback = function()
        local antes = AlanUI:Profiler()
        for _ = 1, 300 do AlanUI:RegistrarConexion({ Connected = false }) end
        for _ = 1, 200 do AlanUI:RegistrarHilo(task.spawn(function() end)) end
        local despues = AlanUI:Profiler()
        local crecioC, crecioH = despues.Conexiones - antes.Conexiones, despues.Hilos - antes.Hilos
        veredicto("Compactación de registros", crecioC <= 64 and crecioH <= 64,
            ("conexiones +%d de 300 (tope 64) · hilos +%d de 200 (tope 64)"):format(crecioC, crecioH))
    end })

-- ── Pruebas de la auditoría (v2.12.7) ──────────────────────────
local SPruebas = TabFugas:CrearSeccion("Pruebas de la auditoría (v2.13.3)")
SPruebas:Parrafo({ Titulo = "Qué prueba", Contenido = "Registro de tema sin errores al destruir, evento ControlRegistrado, ScriptId, notificación de CargarSilencioso, Profiler con marcas y autoguardado sin reescritura. Cada botón abre y cierra una ventana de prueba y da su veredicto." })

local function ventanaDePrueba(titulo, extra)
    local cfg = { Titulo = titulo, TamanoX = TAMANO_X, TamanoY = TAMANO_Y, AutoGuardar = false, PestanaPreinstalada = false, NombreConfig = "vitrina_pruebas_v2127" }
    for k, v in pairs(extra or {}) do cfg[k] = v end
    return AlanUI:CrearVentana(cfg)
end

SPruebas:Boton({ Texto = "✔ Destruir una ventana con 150 controles: sin errores de registro",
    Tooltip = "Crea y destruye una ventana con 150 Toggle y mira la consola: no debe aparecer ningún error de 'attempt to call a nil value'",
    Callback = function()
        task.spawn(function()
            local errores = {}
            local con = game:GetService("LogService").MessageOut:Connect(function(mensaje, tipo)
                if tipo == Enum.MessageType.MessageError then errores[#errores + 1] = mensaje end
            end)
            local W = ventanaDePrueba("Prueba de registro")
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            for i = 1, 150 do sec:Toggle({ Texto = "Toggle " .. i, Flag = "vt_reg_" .. i, Defecto = false }) end
            task.wait(1)
            W:Destruir()
            task.wait(0.6)
            con:Disconnect()
            veredicto("Registro de tema al destruir", #errores == 0, #errores == 0 and "sin errores en la consola" or errores[1])
        end)
    end })

SPruebas:Boton({ Texto = "✔ Evento ControlRegistrado",
    Tooltip = "Escucha AlanUI.Eventos.ControlRegistrado, crea un Toggle (Flag vt_ev) y un Boton y espera recibir los dos con Tipo, Flag y Texto",
    Callback = function()
        task.spawn(function()
            local recibidos = {}
            local con = AlanUI.Eventos.ControlRegistrado:Connect(function(info) recibidos[#recibidos + 1] = info end)
            local W = ventanaDePrueba("Prueba de evento")
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            sec:Toggle({ Texto = "Toggle de prueba", Flag = "vt_ev", Defecto = false })
            sec:Boton({ Texto = "Botón de prueba", Callback = function() end })
            task.wait(0.3)
            con:Disconnect()
            W:Destruir()
            local tog, bot
            for _, info in ipairs(recibidos) do
                if info.Tipo == "Toggle" and info.Flag == "vt_ev" and info.Texto == "Toggle de prueba" then tog = true end
                if info.Tipo == "Boton" and info.Texto == "Botón de prueba" then bot = true end
            end
            veredicto("ControlRegistrado", tog and bot and true or false,
                (" Toggle con Flag: %s · Boton: %s · eventos recibidos: %d"):format(tostring(tog == true), tostring(bot == true), #recibidos))
        end)
    end })

SPruebas:Boton({ Texto = "✔ ScriptId define el NombreConfig",
    Tooltip = "Crea una ventana con ScriptId = 'vitrina/prueba:1' sin NombreConfig: el NombreConfig resultante debe ser 'vitrina_prueba_1'",
    Callback = function()
        task.spawn(function()
            local W = AlanUI:CrearVentana({ Titulo = "Prueba ScriptId", ScriptId = "vitrina/prueba:1", TamanoX = TAMANO_X, TamanoY = TAMANO_Y, AutoGuardar = false, PestanaPreinstalada = false })
            local nombre = W.NombreConfig
            W:Destruir()
            veredicto("ScriptId", nombre == "vitrina_prueba_1", "NombreConfig = " .. tostring(nombre))
        end)
    end })

SPruebas:Boton({ Texto = "🔔 CargarSilencioso normal (debe mostrar «Configuración cargada»)",
    Tooltip = "Guarda y vuelve a cargar el perfil 'vitrina_pruebas_v2127'. Debe aparecer la notificación 'Configuración cargada'",
    Callback = function()
        AlanUI.SaveManager:GuardarSilencioso("vitrina_pruebas_v2127")
        AlanUI.SaveManager:CargarSilencioso("vitrina_pruebas_v2127")
    end })

SPruebas:Boton({ Texto = "🔕 CargarSilencioso con sinNotificar (no debe mostrar nada)",
    Tooltip = "Igual que el anterior pero con el segundo argumento en true. No debe aparecer ninguna notificación",
    Callback = function()
        AlanUI.SaveManager:GuardarSilencioso("vitrina_pruebas_v2127")
        local ok = AlanUI.SaveManager:CargarSilencioso("vitrina_pruebas_v2127", true)
        veredicto("CargarSilencioso sinNotificar", ok == true, ok and "cargó sin notificación (confirma que no apareció ninguna)" or "no pudo cargar el perfil (¿sin acceso a archivos?)")
    end })

SPruebas:Boton({ Texto = "✔ Profiler: sin parámetro y con marcas",
    Tooltip = "Crea una ventana de prueba, toma la marca 'vt_a', agrega 10 Toggle y compara contra 'vt_a' (deben subir los objetos de la interfaz); al destruirla, compara contra 'vt_b' (deben bajar)",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de Profiler")
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            task.wait(1)
            AlanUI:Profiler({ Marca = "vt_a" })
            for i = 1, 10 do sec:Toggle({ Texto = "Toggle " .. i, Flag = "vt_pf_" .. i, Defecto = false }) end
            task.wait(1)
            local d1 = AlanUI:Profiler({ CompararCon = "vt_a", Marca = "vt_b" })
            W:Destruir()
            task.wait(0.6)
            local d2 = AlanUI:Profiler({ CompararCon = "vt_b" })
            local d3 = AlanUI:Profiler({ CompararCon = "no_existe" })
            local crecio = d1.Comparacion and (d1.Comparacion.Deltas.ObjetosGui or 0) > 0
            local bajo = d2.Comparacion and (d2.Comparacion.Deltas.ObjetosGui or 0) < 0
            local sinMarca = d3.Comparacion and d3.Comparacion.Detalle:find("No existe", 1, true) ~= nil
            local prof = AlanUI:Profiler()
            local sinParametro = prof.Comparacion == nil
            local conMemoriaLua = prof.MemoriaLuaMb == nil or prof.MemoriaLuaMb > 0
            local conInstanciasUI = type(prof.InstanciasUI) == "number" and prof.InstanciasUI >= 0
            veredicto("Profiler", crecio and bajo and sinMarca and sinParametro and conMemoriaLua and conInstanciasUI,
                (" Profiler() sin true no trae Comparacion: %s · creció al crear: %s · bajó al destruir: %s · marca inexistente avisa: %s · memoria de Lua (%s MB): %s · instancias de UI vivas (%s): %s"):format(
                    tostring(sinParametro), tostring(crecio == true), tostring(bajo == true), tostring(sinMarca == true),
                    tostring(prof.MemoriaLuaMb), tostring(conMemoriaLua), tostring(prof.InstanciasUI), tostring(conInstanciasUI)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Autoguardado: no reescribe si el contenido es igual",
    Tooltip = "Cuenta las llamadas a writefile: guardar dos veces seguidas lo mismo escribe 0 veces la segunda; cambiar un flag y guardar escribe 1 vez",
    Callback = function()
        local env = (type(getgenv) == "function" and getgenv()) or _G
        local original = env.writefile
        if type(original) ~= "function" then veredicto("Autoguardado sin reescritura", false, "tu ejecutor no expone writefile") return end
        local escrituras = 0
        env.writefile = function(...) escrituras = escrituras + 1 return original(...) end
        local SM = AlanUI.SaveManager
        AlanUI.Flags["vt_autoguardado"] = tostring(os.clock())
        SM:GuardarSilencioso("vitrina_pruebas_v2127")
        local primera = escrituras
        escrituras = 0
        SM:GuardarSilencioso("vitrina_pruebas_v2127")
        local segunda = escrituras
        AlanUI.Flags["vt_autoguardado"] = tostring(os.clock())
        SM:GuardarSilencioso("vitrina_pruebas_v2127")
        local tercera = escrituras - segunda
        env.writefile = original
        veredicto("Autoguardado sin reescritura", primera == 1 and segunda == 0 and tercera == 1,
            (" 1.ª (cambió): %d · 2.ª (igual): %d · 3.ª (cambió): %d  (esperado 1, 0, 1)"):format(primera, segunda, tercera))
    end })

SPruebas:Boton({ Texto = "✔ Temas: claves semánticas, evento y nombres inválidos",
    Tooltip = "Los nueve temas incluidos deben traer Exito, Aviso, Peligro e Info (los temas propios los heredan de Negro al aplicarse), y deben existir Oceano, Ambar y Medianoche",
    Callback = function()
        local faltan, temas = {}, AlanUI.ThemeManager.Temas
        for _, nombre in ipairs({ "Negro", "Neon", "Blanco", "Verde", "Morado", "Rojo", "Oceano", "Ambar", "Medianoche" }) do
            local tema = temas[nombre]
            for _, clave in ipairs({ "Exito", "Aviso", "Peligro", "Info" }) do
                if not tema or typeof(tema[clave]) ~= "Color3" then table.insert(faltan, nombre .. "." .. clave) end
            end
        end
        local nuevos = temas.Oceano ~= nil and temas.Ambar ~= nil and temas.Medianoche ~= nil
        local disparos = 0
        local conexion = AlanUI.Eventos.TemaCambiado:Connect(function() disparos = disparos + 1 end)
        local okValido = pcall(function() AlanUI.ThemeManager:AplicarTema("Negro") end)
        local trasValido = disparos
        local okInvalidos = pcall(function()
            AlanUI.ThemeManager:AplicarTema("NoExiste")
            AlanUI.ThemeManager:AplicarTema(5)
            AlanUI.ThemeManager:AplicarTema(nil)
        end)
        conexion:Disconnect()
        local eventoOk = okValido and trasValido >= 1
        local invalidosOk = okInvalidos and disparos == trasValido
        local detalle = (#faltan == 0 and (nuevos and "todos los temas completos; Oceano, Ambar y Medianoche presentes" or "faltan los temas nuevos") or ("les falta: " .. table.concat(faltan, ", ")))
            .. (" · TemaCambiado al aplicar: %s · nombres inválidos sin error ni evento: %s"):format(tostring(eventoOk), tostring(invalidosOk))
        veredicto("Temas", #faltan == 0 and nuevos and eventoOk and invalidosOk, detalle)
    end })

SPruebas:Boton({ Texto = "🎨 Notificaciones de tipo con el tema actual",
    Tooltip = "Lanza Success, Warning y Error. Cambia de tema en Preinstalada (prueba Blanco) y vuelve a pulsar: las franjas deben tomar los colores del tema, más oscuros en Blanco",
    Callback = function()
        AlanUI:Notificar({ Titulo = "Éxito", Texto = "Color de éxito del tema", Tipo = "Success", Duracion = 4 })
        AlanUI:Notificar({ Titulo = "Aviso", Texto = "Color de aviso del tema", Tipo = "Warning", Duracion = 4 })
        AlanUI:Notificar({ Titulo = "Error", Texto = "Color de peligro del tema", Tipo = "Error", Duracion = 4 })
    end })

SPruebas:Toggle({ Texto = "Atajos: cámbiame y pulsa Ctrl+Z / Ctrl+Y", Flag = "vt_atajo_hist", Defecto = false,
    Tooltip = "Cambia este interruptor varias veces. Ctrl+Z lo devuelve y muestra «Deshecho»; Ctrl+Y (o Ctrl+Shift+Z) lo rehace. Con el cursor sobre un campo de texto no actúan" })

SPruebas:Boton({ Texto = "✔ DiagnosticoCompleto: campos, reporte para soporte y sin parámetro",
    Tooltip = "Guarda en silencio y pide el diagnóstico: debe traer Historial, ErroresRegistrados y UltimoAutoguardado y no traer Reporte; con true debe traer el Reporte (con las Opciones) y copiarlo si el ejecutor puede",
    Callback = function()
        AlanUI.SaveManager:GuardarSilencioso("vitrina_pruebas_v2127")
        local d = AlanUI:DiagnosticoCompleto()
        local ok = type(d.Historial) == "table" and type(d.ErroresRegistrados) == "number" and type(d.UltimoAutoguardado) == "number"
            and d.Reporte == nil and d.Copiado == nil and type(d.FeaturesOk) == "number"
        local dr = AlanUI:DiagnosticoCompleto(true)
        local conOpciones = type(dr.Reporte) == "string" and dr.Reporte:find("Opciones:", 1, true) ~= nil
            and dr.Reporte:find("MaxColaNotificaciones", 1, true) ~= nil
            and dr.Reporte:find("InstanciasUI", 1, true) ~= nil
        local okReporte = type(dr.Reporte) == "string" and #dr.Reporte > 0 and type(dr.Copiado) == "boolean" and conOpciones
        veredicto("DiagnosticoCompleto", ok and okReporte,
            (" Historial: %s · Errores: %s · Último autoguardado: %s · sin parámetro sin Reporte: %s · Reporte con Opciones: %s"):format(
                type(d.Historial), tostring(d.ErroresRegistrados), tostring(d.UltimoAutoguardado), tostring(ok), tostring(okReporte)))
    end })

SPruebas:Boton({ Texto = "⚡ TextoFijo: conexiones por etiqueta truncable",
    Tooltip = "Crea dos ventanas con 100 botones: una con TextoFijo apagado y otra encendido. Con TextoFijo no se conectan los listeners de tamaño y texto de cada etiqueta, así que debe haber menos conexiones",
    Callback = function()
        task.spawn(function()
            local previo = AlanUI.Opciones.TextoFijo
            local function medir(fijo)
                AlanUI.Opciones.TextoFijo = fijo
                local W = ventanaDePrueba("Medición TextoFijo")
                local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
                for i = 1, 100 do sec:Boton({ Texto = "Botón con una etiqueta larga de prueba " .. i, Callback = function() end }) end
                task.wait(1)
                local d = AlanUI:Profiler()
                W:Destruir()
                task.wait(0.6)
                return d.Conexiones
            end
            local apagado = medir(false)
            local encendido = medir(true)
            AlanUI.Opciones.TextoFijo = previo
            veredicto("TextoFijo y conexiones", encendido < apagado,
                (" conexiones con TextoFijo apagado: %d · encendido: %d (debe ser menor)"):format(apagado, encendido))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Controles: Instancia, alias y Label con Defecto",
    Tooltip = "Un Toggle debe exponer Instancia y Fila (ambas Instance), y un Label con Defecto = 'hola' debe mostrar 'hola'",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de controles")
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            local tog = sec:Toggle({ Texto = "Toggle", Flag = "vt_ctl_t", Defecto = false })
            sec:Label({ Texto = "Etiqueta", Flag = "vt_ctl_l", Defecto = "hola" })
            task.wait(0.3)
            local instOk = typeof(tog.Instancia) == "Instance" and typeof(tog.Fila) == "Instance"
            local okGet, valor = pcall(function() return AlanUI.Elementos["vt_ctl_l"].Get() end)
            W:Destruir()
            veredicto("Instancia y Defecto de Label", instOk and okGet and valor == "hola",
                (" Instancia/Fila: %s · Label Get: %s"):format(tostring(instOk), tostring(valor)))
        end)
    end })

SPruebas:Boton({ Texto = "🔒 Locked con BloqueadoMotivo (manual)",
    Tooltip = "Abre una ventana con un Toggle bloqueado con Locked = true y BloqueadoMotivo. Al tocarlo debe mostrar 'Motivo de prueba'. Cierra la ventana con la X",
    Callback = function()
        local W = ventanaDePrueba("Prueba de bloqueo")
        local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
        sec:Toggle({ Texto = "Toca este interruptor", Flag = "vt_lock_t", Defecto = false, Locked = true, BloqueadoMotivo = "Motivo de prueba" })
    end })

SPruebas:Boton({ Texto = "✔ Avisos separados de los errores",
    Tooltip = "Provoca un aviso de ModoDev: debe subir ObtenerErrores('aviso'), no ObtenerErrores(), y salir en consola como 'Aviso'",
    Callback = function()
        task.spawn(function()
            local previo = AlanUI.Opciones.ModoDev
            AlanUI.Opciones.ModoDev = true
            local avisosAntes, erroresAntes = #AlanUI:ObtenerErrores("aviso"), #AlanUI:ObtenerErrores()
            local capt = capturarWarn(function()
                local W = ventanaDePrueba("Prueba de avisos")
                local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
                sec:Toggle({ Texto = "Toggle", Flag = "vt_av_t", Defaut = false })
                task.wait(0.3)
                W:Destruir()
            end)
            AlanUI.Opciones.ModoDev = previo
            local avisosDespues, erroresDespues = #AlanUI:ObtenerErrores("aviso"), #AlanUI:ObtenerErrores()
            local enConsola = algunaContiene(capt, "Aviso", "Defaut")
            veredicto("Avisos separados", avisosDespues > avisosAntes and erroresDespues == erroresAntes and enConsola,
                (" avisos %d→%d · errores %d→%d · «Aviso» en consola: %s"):format(avisosAntes, avisosDespues, erroresAntes, erroresDespues, tostring(enConsola)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Opción mal escrita avisa en ModoDev",
    Tooltip = "Con ModoDev, asignar AlanUI.Opciones.EstiloVisul avisa y sugiere EstiloVisual. Asignar BordeVentanaPredeterminado no debe avisar",
    Callback = function()
        local previo = AlanUI.Opciones.ModoDev
        AlanUI.Opciones.ModoDev = true
        local conTypo = capturarWarn(function() AlanUI.Opciones.EstiloVisul = "x" end)
        local sinFalso = capturarWarn(function() AlanUI.Opciones.BordeVentanaPredeterminado = "tema" end)
        AlanUI.Opciones.BordeVentanaPredeterminado = nil
        rawset(AlanUI.Opciones, "EstiloVisul", nil)
        AlanUI.Opciones.ModoDev = previo
        local sugiere = algunaContiene(conTypo, "EstiloVisul", "EstiloVisual")
        local falso = algunaContiene(sinFalso, "opción desconocida")
        veredicto("Opciones en ModoDev", sugiere and not falso, (" sugerencia: %s · falso aviso: %s"):format(tostring(sugiere), tostring(falso)))
    end })

SPruebas:Boton({ Texto = "✔ NoGuardar y MarcarComoUI temporal",
    Tooltip = "Guarda un perfil con tres flags: el normal debe estar en el archivo; el de NoGuardar y el marcado como temporal no",
    Callback = function()
        task.spawn(function()
            if type(readfile) ~= "function" then veredicto("NoGuardar", false, "tu ejecutor no expone readfile") return end
            local W = ventanaDePrueba("Prueba NoGuardar")
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            sec:Toggle({ Texto = "Normal", Flag = "vt_ng_normal", Defecto = true })
            sec:Toggle({ Texto = "NoGuardar", Flag = "vt_ng_clave", Defecto = true, NoGuardar = true })
            sec:Toggle({ Texto = "Temporal", Flag = "vt_ng_temporal", Defecto = true })
            AlanUI:MarcarComoUI("vt_ng_temporal", "temporal")
            task.wait(0.3)
            AlanUI.SaveManager:GuardarSilencioso("vitrina_pruebas_v2127")
            local okLeer, texto = pcall(readfile, AlanUI.SaveManager.Carpeta .. "/vitrina_pruebas_v2127.json")
            W:Destruir()
            local okDec, datos = pcall(function() return game:GetService("HttpService"):JSONDecode(texto) end)
            local ok = okLeer and okDec and datos.vt_ng_normal ~= nil and datos.vt_ng_clave == nil and datos.vt_ng_temporal == nil
            veredicto("NoGuardar", ok and true or false, ok and "solo el flag normal está en el archivo" or "el archivo no tiene lo esperado")
        end)
    end })

SPruebas:Boton({ Texto = "✔ Cargar: un solo camino (historial, perfil y UI dañados)",
    Tooltip = "Guarda y recarga un perfil: debe restaurar el valor y dejar el historial vacío. Luego carga un archivo de UI dañado y un perfil dañado: cada uno debe devolver false y crear su copia .corrupto",
    Callback = function()
        task.spawn(function()
            if type(writefile) ~= "function" or type(isfile) ~= "function" then veredicto("Cargar", false, "tu ejecutor no expone writefile/isfile") return end
            local SM = AlanUI.SaveManager
            local W = ventanaDePrueba("Prueba de Cargar")
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            sec:Toggle({ Texto = "Valor", Flag = "vt_cg_v", Defecto = false })
            task.wait(0.3)
            AlanUI.Elementos["vt_cg_v"].Set(true)
            SM:GuardarSilencioso("vitrina_pruebas_v2127")
            AlanUI.Elementos["vt_cg_v"].Set(false)
            local cargo = SM:Cargar("vitrina_pruebas_v2127")
            local restaurado = AlanUI.Elementos["vt_cg_v"].Get() == true
            local historialVacio = AlanUI:ObtenerHistorial().Deshacer == 0
            W:Destruir()
            local rutaUI = SM.CarpetaUI .. "/vitrina_corrupto_ui_v2127.json"
            pcall(writefile, rutaUI, "{esto no es json")
            local cargoUI = SM:CargarUI("vitrina_corrupto_ui_v2127")
            local copia = isfile(rutaUI .. ".corrupto")
            if type(delfile) == "function" then pcall(delfile, rutaUI) pcall(delfile, rutaUI .. ".corrupto") end
            local rutaPerfil = SM.Carpeta .. "/vitrina_corrupto_v2128.json"
            pcall(writefile, rutaPerfil, "{esto no es json")
            local cargoPerfil = SM:Cargar("vitrina_corrupto_v2128")
            local copiaPerfil = isfile(rutaPerfil .. ".corrupto")
            if type(delfile) == "function" then pcall(delfile, rutaPerfil) pcall(delfile, rutaPerfil .. ".corrupto") end
            veredicto("Cargar con un solo camino", cargo == true and restaurado and historialVacio and cargoUI == false and copia and cargoPerfil == false and copiaPerfil,
                (" restaurado: %s · historial vacío: %s · CargarUI dañado→false: %s · copia .corrupto (UI): %s · perfil dañado→false: %s · copia .corrupto (perfil): %s"):format(
                    tostring(restaurado), tostring(historialVacio), tostring(cargoUI == false), tostring(copia), tostring(cargoPerfil == false), tostring(copiaPerfil)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Preinstalada: Excluir",
    Tooltip = "AgregarPestanaPreinstalada({ Excluir = { 'Historial' } }) crea todos los módulos menos Historial; luego pedir solo Historial debe funcionar y pedir Sistema debe devolver nil (ya existe)",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de Excluir")
            local t1 = W:AgregarPestanaPreinstalada({ Excluir = { "Historial" } })
            local t2 = W:AgregarPestanaPreinstalada({ Modulos = { "Historial" } })
            local t3 = W:AgregarPestanaPreinstalada({ Modulos = { "Sistema" } })
            task.wait(0.3)
            W:Destruir()
            veredicto("Excluir", t1 ~= nil and t2 ~= nil and t3 == nil,
                (" con Excluir: %s · Historial aparte: %s · Sistema repetido → nil: %s"):format(tostring(t1 ~= nil), tostring(t2 ~= nil), tostring(t3 == nil)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Forma corta de los controles",
    Tooltip = "Crea controles con el Texto como primer argumento (Toggle, Slider, Dropdown, Input, Label, Boton) y comprueba valores, Flag derivada y Callback",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de forma corta")
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            local llamadas = 0
            sec:Toggle("Corto Toggle", true, function() llamadas = llamadas + 1 end)
            sec:Slider("Corto Slider", 0, 10, 5)
            sec:Dropdown("Corto Dropdown", { "A", "B" }, "B")
            sec:Input("Corto Input", "hola")
            sec:Label("Corto Label", "valor")
            sec:Slider("Corto Nil", nil, 10, 5)
            local boton = sec:Boton("Corto Boton", function() end)
            task.wait(0.3)
            local E = AlanUI.Elementos
            local okToggle = E["Corto Toggle"] and E["Corto Toggle"].Get() == true
            local okSlider = E["Corto Slider"] and E["Corto Slider"].Get() == 5
            local okDrop = E["Corto Dropdown"] and E["Corto Dropdown"].Get() == "B"
            local okInput = E["Corto Input"] and E["Corto Input"].Get() == "hola"
            local antes = llamadas
            if E["Corto Toggle"] then E["Corto Toggle"].Set(false, true) end
            local okNil = E["Corto Nil"] and E["Corto Nil"].Get() == 5
            local okCallback = llamadas == antes + 1
            W:Destruir()
            local ok = okToggle and okSlider and okDrop and okInput and okNil and okCallback and boton ~= nil
            veredicto("Forma corta", ok and true or false,
                (" Toggle: %s · Slider: %s · Dropdown: %s · Input: %s · nil en su lugar: %s · Callback: %s · Boton: %s"):format(
                    tostring(okToggle == true), tostring(okSlider == true), tostring(okDrop == true), tostring(okInput == true), tostring(okNil == true), tostring(okCallback), tostring(boton ~= nil)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Notificar con texto: Notificar('Título', 'Texto')",
    Tooltip = "Lanza dos notificaciones con la forma corta: solo título, y título con texto. Deben verse las dos",
    Callback = function()
        local ok1 = pcall(function() AlanUI:Notificar("Solo título", nil) end)
        local ok2 = pcall(function() AlanUI:Notificar("Título", "Con texto, forma corta") end)
        veredicto("Notificar corta", ok1 and ok2, "deben haber aparecido dos notificaciones")
    end })

SPruebas:Boton({ Texto = "✔ MarcarComoUI: categoría desconocida avisa",
    Tooltip = "Con ModoDev, MarcarComoUI('x', 'temp') debe avisar; con 'ui' o 'temporal' no debe avisar",
    Callback = function()
        local previo = AlanUI.Opciones.ModoDev
        AlanUI.Opciones.ModoDev = true
        local conTypo = capturarWarn(function() AlanUI:MarcarComoUI("vt_mc_x", "temp") end)
        local sinFalso = capturarWarn(function() AlanUI:MarcarComoUI("vt_mc_y", "temporal") AlanUI:MarcarComoUI("vt_mc_z", "ui") end)
        AlanUI.Opciones.ModoDev = previo
        local avisa = algunaContiene(conTypo, "categoría desconocida")
        local falso = algunaContiene(sinFalso, "categoría desconocida")
        veredicto("MarcarComoUI", avisa and not falso, (" avisa con 'temp': %s · falso aviso con valores válidos: %s"):format(tostring(avisa), tostring(falso)))
    end })

SPruebas:Boton({ Texto = "✔ CrearVentana con Posicion (alias de PosicionInicial)",
    Tooltip = "Crea una ventana con Posicion = UDim2.new(0.3, 0, 0.4, 0) y comprueba que la ventana nace ahí",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de Posicion", { Posicion = UDim2.new(0.3, 0, 0.4, 0), GuardarPosicion = false })
            task.wait(0.5)
            local main = W._main
            local pos = main and main.Position
            W:Destruir()
            local ok = pos ~= nil and math.abs(pos.X.Scale - 0.3) < 0.001 and math.abs(pos.Y.Scale - 0.4) < 0.001
            veredicto("Alias Posicion", ok, pos and (" posición: %s"):format(tostring(pos)) or " la ventana no expone _main")
        end)
    end })

SPruebas:Boton({ Texto = "✔ SM:Configurar con carpeta de UI",
    Tooltip = "SM:Configurar(nil, 'X') cambia solo CarpetaUI; con una carpeta sola no toca CarpetaUI",
    Callback = function()
        local SM = AlanUI.SaveManager
        local carpeta, carpetaUI = SM.Carpeta, SM.CarpetaUI
        SM:Configurar(nil, "AlanUI/Config/_ui_prueba")
        local soloUI = SM.Carpeta == carpeta and SM.CarpetaUI == "AlanUI/Config/_ui_prueba"
        SM:Configurar(carpeta)
        local sinTocarUI = SM.CarpetaUI == "AlanUI/Config/_ui_prueba"
        SM:Configurar(carpeta, carpetaUI)
        local restaurado = SM.Carpeta == carpeta and SM.CarpetaUI == carpetaUI
        veredicto("SM:Configurar", soloUI and sinTocarUI and restaurado,
            (" solo UI: %s · una carpeta sola no toca UI: %s · restaurado: %s"):format(tostring(soloUI), tostring(sinTocarUI), tostring(restaurado)))
    end })

SPruebas:Boton({ Texto = "🗑 Modal de cierre con Confirmar (manual)",
    Tooltip = "Abre una ventana de prueba. Pulsa su X: debe salir el modal «¿Cerrar la interfaz?» con Cancelar y Cerrar (rojo). Cancelar la deja; Cerrar la cierra",
    Callback = function()
        ventanaDePrueba("Prueba de cierre")
    end })

SPruebas:Boton({ Texto = "✔ Atajos y transparencia de la ventana",
    Tooltip = "Comprueba Opciones.Atajos, Atajos = false, un atajo no válido y el slider de transparencia (0 a 60%) sobre una ventana con Preinstalada",
    Callback = function()
        task.spawn(function()
            local base = AlanUI.Opciones.Atajos
            local porDefecto = type(base) == "table" and base.Ocultar == "RightShift+H" and base.Resetear == "RightShift+R"
                and base.Reejecutar == "RightShift+L" and base.Cerrar == "RightShift+Q"
            local W = ventanaDePrueba("Prueba de atajos", { PestanaPreinstalada = true, GuardarPosicion = false })
            task.wait(0.8)
            local texto = W._atajosTexto
            local atajosOk = texto and texto.Cerrar == "RightShift+Q" and texto.Ocultar == "RightShift+H"
            local slider = AlanUI.Elementos["sys_transparencia"]
            local transparenciaOk = false
            if slider and W._main then
                slider.Set(40, true)
                local alta = math.abs(W._main.BackgroundTransparency - 0.4) < 0.001
                slider.Set(0, true)
                transparenciaOk = alta and W._main.BackgroundTransparency == 0
            end
            W:Destruir()
            task.wait(0.4)
            local W2 = ventanaDePrueba("Prueba sin atajos", { Atajos = false })
            local sinAtajos = next(W2._atajosTexto or { x = true }) == nil
            W2:Destruir()
            task.wait(0.4)
            local capt = capturarWarn(function()
                local W3 = ventanaDePrueba("Prueba de atajo no válido", { Atajos = { Cerrar = "Foo+X" } })
                local sinCerrar = W3._atajosTexto and W3._atajosTexto.Cerrar == nil
                W3:Destruir()
                _G.vt_atajo_sin_cerrar = sinCerrar
            end)
            local avisa = algunaContiene(capt, "atajo no válido")
            local sinCerrar = _G.vt_atajo_sin_cerrar == true
            _G.vt_atajo_sin_cerrar = nil
            veredicto("Atajos y transparencia", (porDefecto and atajosOk and transparenciaOk and sinAtajos and avisa and sinCerrar) and true or false,
                (" por defecto: %s · en la ventana: %s · transparencia 0↔40%%: %s · Atajos=false: %s · atajo no válido avisa: %s y se ignora: %s"):format(
                    tostring(porDefecto == true), tostring(atajosOk == true), tostring(transparenciaOk), tostring(sinAtajos), tostring(avisa == true), tostring(sinCerrar)))
        end)
    end })

SPruebas:Boton({ Texto = "⌨️ Atajos de teclado (manual, solo PC)",
    Tooltip = "Abre una ventana de prueba. RightControl minimiza/restaura; RightShift+H oculta/muestra; RightShift+R resetea el Toggle (con confirmación); RightShift+L muestra una notificación; RightShift+Q cierra (con confirmación)",
    Callback = function()
        local W = ventanaDePrueba("Prueba de atajos", {
            AlReejecutar = function() AlanUI:Notificar({ Titulo = "🔁 AlReejecutar llamado", Texto = "RightShift+L funciona", Tipo = "Success", Duracion = 3 }) end,
        })
        local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Atajos")
        sec:Toggle({ Texto = "Enciéndeme y pulsa RightShift+R", Flag = "vt_atajo_reset", Defecto = false })
        sec:Parrafo({ Titulo = "Combinaciones", Contenido = "RightControl: minimizar / restaurar\nRightShift+H: ocultar / mostrar todo\nRightShift+R: resetear valores\nRightShift+L: re-ejecutar\nRightShift+Q: cerrar" })
    end })

SPruebas:Boton({ Texto = "🧭 Indicador de pestaña deslizante (manual)",
    Tooltip = "Abre una ventana con cuatro pestañas. Al cambiar de una a otra, la barrita de acento debe deslizarse desde la anterior en vez de aparecer de golpe",
    Callback = function()
        local W = ventanaDePrueba("Prueba de pestañas")
        for _, nombre in ipairs({ "Uno", "Dos", "Tres", "Cuatro" }) do
            W:CrearTab(nombre, "@info"):CrearSeccion("Pestaña " .. nombre):Label(nombre, "Cambia de pestaña y mira la barrita")
        end
    end })

SPruebas:Boton({ Texto = "✔ Valores extremos en controles, ventana y notificaciones",
    Tooltip = "Crea un control de cada tipo y le pasa valores raros (NaN, infinito, textos, tablas, funciones...) con Set y Get; luego llama a los métodos de la ventana repetidos y con argumentos raros. No debe lanzar errores ni escribirlos en la consola",
    Callback = function()
        task.spawn(function()
            local errores = {}
            local conLog = game:GetService("LogService").MessageOut:Connect(function(mensaje, tipo)
                if tipo == Enum.MessageType.MessageError then errores[#errores + 1] = mensaje end
            end)
            local W = ventanaDePrueba("Prueba de valores extremos")
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            sec:Boton("Fz Boton", function() end)
            sec:Toggle("Fz Toggle", false)
            sec:Casilla("Fz Casilla", false)
            sec:Slider("Fz Slider", 0, 100, 50)
            sec:RangeSlider({ Texto = "Fz Rango", Flag = "Fz Rango", Min = 0, Max = 100, Defecto = { min = 20, max = 80 } })
            sec:NumberStepper({ Texto = "Fz Numero", Flag = "Fz Numero", Min = 0, Max = 10, Defecto = 5 })
            sec:Input("Fz Input", "x")
            sec:TagInput({ Texto = "Fz Tags", Flag = "Fz Tags", Defecto = { "a" } })
            sec:Dropdown("Fz Drop", { "A", "B", "C" }, "A")
            sec:Dropdown({ Texto = "Fz Multi", Flag = "Fz Multi", Opciones = { "A", "B" }, Multi = true })
            sec:RadioGroup("Fz Radio", { "A", "B" }, "A")
            sec:ColorPicker("Fz Color", Color3.new(1, 0, 0))
            sec:Keybind({ Texto = "Fz Tecla", Flag = "Fz Tecla" })
            sec:Progreso({ Texto = "Fz Progreso", Flag = "Fz Progreso", Defecto = 35 })
            sec:Label({ Texto = "Fz Label", Flag = "Fz Label", Valor = "x" })
            sec:Parrafo("Fz Parrafo", "contenido")
            sec:Divider({ Texto = "Fz Divider" })
            task.wait(0.5)

            local raros = { true, false, 0, -1, 1e9, -1e9, math.huge, -math.huge, 0 / 0, "", "texto", "123", "  ",
                {}, { 1, 2, 3 }, { min = 1, max = 2 }, { A = true }, Color3.new(0, 1, 0), Vector2.new(1, 1), Enum.KeyCode.F, function() end }
            local lanzan = {}
            for flag, elem in pairs(AlanUI.Elementos) do
                if type(elem.Set) == "function" then
                    local okNil, errNil = pcall(elem.Set)
                    if not okNil then lanzan[#lanzan + 1] = flag .. ".Set(nil): " .. tostring(errNil):sub(1, 90) end
                    for indice, valor in ipairs(raros) do
                        local ok, err = pcall(elem.Set, valor)
                        if not ok then lanzan[#lanzan + 1] = ("%s.Set(%s #%d): %s"):format(flag, typeof(valor), indice, tostring(err):sub(1, 90)) end
                        if type(elem.Get) == "function" then
                            local okGet, errGet = pcall(elem.Get)
                            if not okGet then lanzan[#lanzan + 1] = ("%s.Get tras Set(%s #%d): %s"):format(flag, typeof(valor), indice, tostring(errGet):sub(1, 90)) end
                        end
                    end
                end
            end
            task.wait(0.3)

            local metodos = {
                function() W:Minimizar() end, function() W:Mostrar() end, function() W:Plegar() end, function() W:Desplegar() end,
                function() W:AlternarPliegue() end, function() W:Buscar("(") end, function() W:Buscar("%") end, function() W:Buscar("[") end,
                function() W:Buscar(string.rep("x", 500)) end, function() W:Buscar("") end,
                function() W:CambiarTema("Blanco") end, function() W:CambiarTema("NoExiste") end, function() W:CambiarTema(nil) end,
                function() W:EstablecerBorde(nil) end, function() W:EstablecerBorde("tema") end, function() W:EstablecerBorde({}) end,
                function() W:CambiarModo("mini") end, function() W:CambiarOrientacion("horizontal") end, function() W:CambiarOrientacion("vertical") end,
                function() W:Resetear() end, function() W:ResetearPosicion() end, function() W:EstaVisible() end, function() W:EstaPlegada() end,
                function() AlanUI:Notificar(nil) end, function() AlanUI:Notificar({}) end, function() AlanUI:Notificar({ Titulo = 123, Texto = {} }) end,
                function() AlanUI:Notificar(5) end, function() AlanUI:Notificar({ Titulo = "x", Duracion = -1 }) end,
                function() AlanUI:Notificar({ Titulo = "x", Duracion = "mucho", Tipo = "NoExiste" }) end,
            }
            for ronda = 1, 3 do
                for indice, metodo in ipairs(metodos) do
                    local ok, err = pcall(metodo)
                    if not ok then lanzan[#lanzan + 1] = ("ventana #%d (ronda %d): %s"):format(indice, ronda, tostring(err):sub(1, 90)) end
                end
            end
            task.wait(1)
            pcall(function() W:CambiarTema("Negro") end)
            W:Destruir()
            task.wait(0.6)
            conLog:Disconnect()

            local detalle = {}
            for i = 1, math.min(#lanzan, 6) do detalle[#detalle + 1] = lanzan[i] end
            if #errores > 0 then detalle[#detalle + 1] = "consola: " .. tostring(errores[1]):sub(1, 90) end
            veredicto("Valores extremos", #lanzan == 0 and #errores == 0,
                (#lanzan == 0 and #errores == 0) and "ninguna llamada lanzó error y la consola quedó limpia"
                    or (("%d llamadas lanzaron error · %d errores de consola · "):format(#lanzan, #errores) .. table.concat(detalle, " | ")))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Pestañas y secciones con forma corta",
    Tooltip = "CrearTab y CrearSeccion aceptan también una tabla con Texto, y tienen nombre por defecto: CrearTab({ Texto = 'A', Icono = '@info' }), CrearSeccion({ Texto = 'B', Colapsable = false }) y CrearSeccion() sin nombre",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de pestañas")
            local okTabla, tabla = pcall(function() return W:CrearTab({ Texto = "Con tabla", Icono = "@info" }) end)
            local okSec, secTabla = pcall(function() return tabla:CrearSeccion({ Texto = "Sección con tabla", Colapsable = false }) end)
            local okSinNombre, secSinNombre = pcall(function() return tabla:CrearSeccion() end)
            local okTabSinNombre, tabSinNombre = pcall(function() return W:CrearTab() end)
            local okControl = okSec and pcall(function() secTabla:Toggle("Toggle en sección con tabla", false) end)
            task.wait(0.3)
            W:Destruir()
            local ok = okTabla and tabla ~= nil and okSec and secTabla ~= nil and okSinNombre and secSinNombre ~= nil
                and okTabSinNombre and tabSinNombre ~= nil and okControl
            veredicto("Pestañas y secciones", ok and true or false,
                (" CrearTab(tabla): %s · CrearSeccion(tabla): %s · CrearSeccion(): %s · CrearTab(): %s · control dentro: %s"):format(
                    tostring(okTabla and tabla ~= nil), tostring(okSec and secTabla ~= nil), tostring(okSinNombre and secSinNombre ~= nil),
                    tostring(okTabSinNombre and tabSinNombre ~= nil), tostring(okControl == true)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Búsqueda sin acentos ni mayúsculas",
    Tooltip = "Un control llamado 'Configuración avanzada' debe aparecer al buscar 'configuracion' y 'CONFIGURACIÓN', y ocultarse con un texto que no coincide",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de búsqueda")
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            local con = sec:Toggle("Configuración avanzada", false)
            local otro = sec:Toggle("Otra cosa distinta", false)
            task.wait(0.4)
            local function buscar(texto)
                W:Buscar(texto)
                task.wait(0.8)
                return con.Fila.Visible, otro.Fila.Visible
            end
            local a1, b1 = buscar("configuracion")
            local a2 = buscar("CONFIGURACIÓN")
            local a3, b3 = buscar("zzz")
            local a4, b4 = buscar("")
            W:Destruir()
            veredicto("Búsqueda sin acentos", a1 and not b1 and a2 and not a3 and not b3 and a4 and b4,
                (" 'configuracion': %s/%s · 'CONFIGURACIÓN': %s · 'zzz': %s/%s · vacío: %s/%s (control/otro)"):format(
                    tostring(a1), tostring(b1), tostring(a2), tostring(a3), tostring(b3), tostring(a4), tostring(b4)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Nombres de guardado inválidos",
    Tooltip = "Guardar, Cargar, Eliminar, CambiarPerfil y las versiones de interfaz rechazan nombres con / \\ : * ? \" < > | o vacíos, y siguen funcionando con un nombre válido",
    Callback = function()
        if type(isfile) ~= "function" or type(delfile) ~= "function" then veredicto("Nombres de guardado", false, "tu ejecutor no expone isfile/delfile") return end
        local SM = AlanUI.SaveManager
        local invalidos = { "../x", "a/b", "x:y", "a|b", "", string.rep("n", 61) }
        local rechazos, total = 0, 0
        for _, nombre in ipairs(invalidos) do
            local resultados = {
                SM:Guardar(nombre), SM:GuardarSilencioso(nombre), SM:Cargar(nombre), SM:CargarSilencioso(nombre),
                SM:Eliminar(nombre), SM:GuardarUI(nombre), SM:CargarUI(nombre), SM:EliminarUI(nombre), SM:CambiarPerfil({}, nombre),
            }
            for _, r in ipairs(resultados) do total = total + 1 if r == false then rechazos = rechazos + 1 end end
        end
        local ruta = SM.Carpeta .. "/vitrina_valido_v2127.json"
        local guardo = SM:Guardar("vitrina_valido_v2127") == true
        local existe = isfile(ruta)
        local elimino = SM:Eliminar("vitrina_valido_v2127") == true
        veredicto("Nombres de guardado", rechazos == total and guardo and existe and elimino,
            (" inválidos rechazados: %d/%d · válido guardó: %s · existía: %s · eliminó: %s"):format(rechazos, total, tostring(guardo), tostring(existe), tostring(elimino)))
    end })

SPruebas:Boton({ Texto = "✔ Eventos: conexiones desconectadas",
    Tooltip = "Conecta y desconecta 3000 veces a un evento: las desconectadas no se llaman, la nueva sí, y emitir el evento sigue siendo rápido",
    Callback = function()
        local evento = AlanUI.Eventos.TabCambiada
        local viejas = 0
        for _ = 1, 3000 do
            local c = evento:Connect(function() viejas = viejas + 1 end)
            c:Disconnect()
        end
        local nuevas = 0
        local viva = evento:Connect(function() nuevas = nuevas + 1 end)
        local inicio = os.clock()
        for _ = 1, 500 do evento:Fire("vt") end
        local tiempo = os.clock() - inicio
        viva:Disconnect()
        veredicto("Eventos desconectados", viejas == 0 and nuevas == 500 and tiempo < 0.5,
            (" desconectadas llamadas: %d · nueva llamada: %d/500 · 500 emisiones: %.3f s"):format(viejas, nuevas, tiempo))
    end })

SPruebas:Boton({ Texto = "✔ Colores de estado de un tema propio",
    Tooltip = "Un tema propio sin Exito/Aviso/Peligro/Info recibe un juego claro si su fondo es claro y oscuro si es oscuro; no los del tema anterior",
    Callback = function()
        if type(readfile) ~= "function" then veredicto("Colores de estado", false, "tu ejecutor no expone readfile") return end
        local TM = AlanUI.ThemeManager
        local ruta = AlanUI.SaveManager.Carpeta .. "/tema.json"
        local function exitoG(fondo)
            TM:AplicarTema({ Background = fondo })
            TM:GuardarTemaActual()
            local ok, texto = pcall(readfile, ruta)
            local okDec, datos = pcall(function() return game:GetService("HttpService"):JSONDecode(texto) end)
            return ok and okDec and datos.Exito and datos.Exito[2] or nil
        end
        local claro = exitoG(Color3.new(1, 1, 1))
        local oscuro = exitoG(Color3.new(0.08, 0.08, 0.1))
        TM:AplicarTema("Negro")
        veredicto("Colores de estado", claro ~= nil and oscuro ~= nil and claro < 0.7 and oscuro > 0.7,
            (" verde (G) con fondo claro: %s · con fondo oscuro: %s (claro < 0,7 < oscuro)"):format(tostring(claro), tostring(oscuro)))
    end })

SPruebas:Boton({ Texto = "✔ Tocar afuera confirma el valor escrito",
    Tooltip = "Escribe en la caja de un Slider, un NumberStepper y un Input y suelta el foco sin Enter: el número válido se aplica, el texto inválido se restaura, y el Input ejecuta su Callback solo en táctil",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de foco")
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            local llamadas = 0
            local slider = sec:Slider("Cf Slider", 0, 100, 50)
            local numero = sec:NumberStepper({ Texto = "Cf Numero", Flag = "Cf Numero", Min = 0, Max = 10, Defecto = 5 })
            local entrada = sec:Input({ Texto = "Cf Input", Flag = "Cf Input", Defecto = "a", Callback = function() llamadas = llamadas + 1 end })
            task.wait(0.6)
            local function escribir(control, texto)
                local caja
                for _, d in ipairs(control.Fila:GetDescendants()) do
                    if d:IsA("TextBox") then caja = d break end
                end
                if not caja then return nil end
                pcall(function() caja:CaptureFocus() end)
                caja.Text = texto
                pcall(function() caja:ReleaseFocus(false) end)
                task.wait(0.4)
                return caja
            end
            local cajaS = escribir(slider, "73")
            local okSlider = AlanUI.Elementos["Cf Slider"].Get() == 73
            local cajaInvalida = escribir(slider, "abc")
            local sinCambio = AlanUI.Elementos["Cf Slider"].Get() == 73
            local textoRestaurado = cajaInvalida and cajaInvalida.Text:find("73", 1, true) ~= nil
            escribir(numero, "7")
            local okNumero = AlanUI.Elementos["Cf Numero"].Get() == 7
            escribir(entrada, "nuevo")
            local okInput = AlanUI.Elementos["Cf Input"].Get() == "nuevo"
            local callbackEsperado = AlanUI.Capacidades.EsTactil and 1 or 0
            W:Destruir()
            veredicto("Tocar afuera confirma", cajaS ~= nil and okSlider and sinCambio and textoRestaurado and okNumero and okInput and llamadas == callbackEsperado,
                (" Slider 73: %s · 'abc' no cambia: %s · texto restaurado: %s · NumberStepper 7: %s · Input: %s · Callback del Input: %d (esperado %d, táctil=%s)"):format(
                    tostring(okSlider), tostring(sinCambio), tostring(textoRestaurado == true), tostring(okNumero), tostring(okInput), llamadas, callbackEsperado, tostring(AlanUI.Capacidades.EsTactil)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Toggle con Contenido",
    Tooltip = "Los controles de Contenido aparecen solo con el Toggle activado, incluso anidados, y viven dentro de un marco propio",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de Contenido")
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            local hijo, anidado
            sec:Toggle({ Texto = "Tc Modulo", Flag = "Tc Modulo", Defecto = false, Contenido = function(sub)
                hijo = sub:Slider("Tc Slider", 0, 10, 5)
                anidado = sub:Toggle({ Texto = "Tc Anidado", Flag = "Tc Anidado", Defecto = false, Contenido = function(sub2)
                    sub2:Label("Tc Nieto", "x")
                end })
            end })
            task.wait(0.5)
            local marco = hijo and hijo.Fila and hijo.Fila.Parent
            local ocultoAlInicio = marco ~= nil and marco.Visible == false
            AlanUI.Elementos["Tc Modulo"].Set(true, true)
            task.wait(0.4)
            local visibleAlEncender = marco ~= nil and marco.Visible == true
            AlanUI.Elementos["Tc Modulo"].Set(false, true)
            task.wait(0.4)
            local ocultoAlApagar = marco ~= nil and marco.Visible == false
            local anidadoDentro = anidado ~= nil and anidado.Fila ~= nil and anidado.Fila.Parent == marco
            W:Destruir()
            veredicto("Toggle con Contenido", ocultoAlInicio and visibleAlEncender and ocultoAlApagar and anidadoDentro,
                (" oculto al inicio: %s · visible al encender: %s · oculto al apagar: %s · anidado dentro: %s"):format(
                    tostring(ocultoAlInicio), tostring(visibleAlEncender), tostring(ocultoAlApagar), tostring(anidadoDentro)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Confirmar con campo de texto",
    Tooltip = "AlanUI:Confirmar({ Input = { Validar = ... } }): con texto inválido el modal sigue abierto y avisa; con texto válido se cierra y el Callback recibe el texto",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de Confirmar con campo")
            task.wait(0.4)
            local recibido
            local modal = AlanUI:Confirmar({
                Titulo = "Nombre", Contenido = "Escribe al menos 3 letras",
                Input = { Defecto = "ab", Placeholder = "Nombre", Validar = function(texto) return #texto >= 3, "Mínimo 3 letras" end },
                BotonAceptar = { Texto = "Guardar", Callback = function(_, texto) recibido = texto end },
            })
            task.wait(0.5)
            local caja
            if modal then
                for _, d in ipairs(modal.Fondo:GetDescendants()) do
                    if d:IsA("TextBox") then caja = d break end
                end
            end
            if not (modal and caja) then W:Destruir() veredicto("Confirmar con campo", false, "no se creó el modal o el campo de texto") return end
            modal.Presionar(1)
            task.wait(0.3)
            local sigueAbierto = modal.Fondo.Parent ~= nil and recibido == nil
            caja.Text = "abcd"
            modal.Presionar(1)
            task.wait(0.5)
            local cerro = modal.Fondo.Parent == nil
            W:Destruir()
            veredicto("Confirmar con campo", sigueAbierto and cerro and recibido == "abcd",
                (" texto inválido mantiene abierto: %s · texto válido cierra: %s · Callback recibió: %s"):format(tostring(sigueAbierto), tostring(cerro), tostring(recibido)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Formato, Alto, Paleta y Watermark",
    Tooltip = "Slider con Formato ('50 FPS'), Divider con Alto = 50, ColorPicker con Paleta propia y CrearVentana con Watermark",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de extensiones", { Watermark = "Marca | 1.0" })
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            local slider = sec:Slider({ Texto = "Sf", Flag = "Sf", Min = 0, Max = 100, Defecto = 50, Formato = function(valor) return valor .. " FPS" end })
            local divisor = sec:Divider({ Alto = 50 })
            local color = sec:ColorPicker({ Texto = "Cp", Flag = "Cp", Defecto = Color3.new(1, 0, 0), Paleta = { Color3.fromRGB(1, 2, 3), Color3.fromRGB(4, 5, 6) } })
            task.wait(0.6)
            local caja
            for _, d in ipairs(slider.Fila:GetDescendants()) do
                if d:IsA("TextBox") then caja = d break end
            end
            local okFormato = caja ~= nil and caja.Text == "50 FPS"
            AlanUI.Elementos["Sf"].Set(60)
            task.wait(0.4)
            okFormato = okFormato and caja.Text == "60 FPS"
            local instDivisor = (typeof(divisor) == "Instance" and divisor) or (type(divisor) == "table" and (divisor.Instancia or divisor.Fila)) or nil
            local okAlto = instDivisor ~= nil and instDivisor.Size.Y.Offset == 50
            local okPaleta = false
            for _, d in ipairs(color.Fila:GetDescendants()) do
                if d:IsA("GuiObject") and d.BackgroundColor3 == Color3.fromRGB(1, 2, 3) then okPaleta = true break end
            end
            local okMarca = false
            local gui = W._main and W._main:FindFirstAncestorOfClass("ScreenGui")
            if gui then
                for _, d in ipairs(gui:GetDescendants()) do
                    if d:IsA("TextLabel") and d.Text == "Marca | 1.0" then okMarca = true break end
                end
            end
            W:Destruir()
            veredicto("Formato, Alto, Paleta y Watermark", okFormato and okAlto and okPaleta and okMarca,
                (" Formato: %s · Alto 50: %s · Paleta propia: %s · Watermark: %s"):format(tostring(okFormato), tostring(okAlto), tostring(okPaleta), tostring(okMarca)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Confirmar con campo: cancelar sin validar",
    Tooltip = "Con Input y Validar, el botón de cancelar cierra sin validar y recibe el texto; el de aceptar sigue validando",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de cancelar con campo")
            task.wait(0.4)
            local textoCancelar, textoAceptar
            local modal = AlanUI:Confirmar({
                Titulo = "Nombre", Contenido = "Escribe al menos 3 letras",
                Input = { Defecto = "x", Validar = function(texto) return #texto >= 3, "Mínimo 3 letras" end },
                BotonCancelar = { Texto = "Cancelar", Callback = function(_, texto) textoCancelar = texto end },
                BotonAceptar = { Texto = "Guardar", Callback = function(_, texto) textoAceptar = texto end },
            })
            task.wait(0.5)
            if not modal then W:Destruir() veredicto("Cancelar sin validar", false, "no se creó el modal") return end
            local okTexto = modal.ObtenerTexto and modal.ObtenerTexto() == "x"
            modal.Presionar(2)
            task.wait(0.3)
            local aceptarValida = modal.Fondo.Parent ~= nil and textoAceptar == nil
            modal.Presionar(1)
            task.wait(0.5)
            local cancelarCierra = modal.Fondo.Parent == nil and textoCancelar == "x"
            W:Destruir()
            veredicto("Cancelar sin validar", okTexto and aceptarValida and cancelarCierra,
                (" ObtenerTexto: %s · Guardar con texto inválido no cierra: %s · Cancelar cierra y recibe el texto: %s"):format(
                    tostring(okTexto), tostring(aceptarValida), tostring(cancelarCierra)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Formato escrito, Divider con Texto, Paleta y Columnas cortas",
    Tooltip = "Escribir '75 FPS' en un Slider con Formato aplica 75; Divider con Texto no baja de 38; una Paleta de 15 colores muestra 12; las columnas aceptan la forma corta",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de límites")
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            local slider = sec:Slider({ Texto = "Sf2", Flag = "Sf2", Min = 0, Max = 100, Defecto = 50, Formato = function(valor) return valor .. " FPS" end })
            local divisor = sec:Divider({ Texto = "Título", Alto = 20 })
            local paleta, esperados = {}, {}
            for i = 1, 15 do paleta[i] = Color3.fromRGB(i, 100, 100) end
            local color = sec:ColorPicker({ Texto = "Cp2", Flag = "Cp2", Defecto = Color3.new(1, 0, 0), Paleta = paleta })
            local izq = sec:Columnas({})
            local enColumna = izq:Slider("Col S", 0, 10, 5)
            task.wait(0.6)
            local caja
            for _, d in ipairs(slider.Fila:GetDescendants()) do
                if d:IsA("TextBox") then caja = d break end
            end
            if caja then
                pcall(function() caja:CaptureFocus() end)
                caja.Text = "75 FPS"
                pcall(function() caja:ReleaseFocus(false) end)
                task.wait(0.4)
            end
            local okEscrito = caja ~= nil and AlanUI.Elementos["Sf2"].Get() == 75 and caja.Text == "75 FPS"
            local okAltoTexto = type(divisor) == "table" and divisor.Instancia ~= nil and divisor.Instancia.Size.Y.Offset == 38
            local visibles = 0
            for i = 1, 15 do esperados[("%d,100,100"):format(i)] = true end
            for _, d in ipairs(color.Fila:GetDescendants()) do
                if d:IsA("GuiObject") then
                    local c = d.BackgroundColor3
                    local clave = ("%d,%d,%d"):format(math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
                    if esperados[clave] then visibles = visibles + 1 end
                end
            end
            local okLimite = visibles == 12
            local okColumna = enColumna ~= nil and AlanUI.Elementos["Col S"] ~= nil and AlanUI.Elementos["Col S"].Get() == 5
            W:Destruir()
            veredicto("Formato escrito, Divider, Paleta y Columnas", okEscrito and okAltoTexto and okLimite and okColumna,
                (" '75 FPS' aplica 75: %s · Divider con Texto = 38: %s · Paleta limitada a 12 (hay %d): %s · Columnas forma corta: %s"):format(
                    tostring(okEscrito), tostring(okAltoTexto), visibles, tostring(okLimite), tostring(okColumna)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Minimizar y Mostrar la ventana (los tres modos)",
    Tooltip = "Minimiza y vuelve a mostrar una ventana de prueba con 40 controles en cada modo de AlanUI.Opciones.AnimacionVentana (fantasma, tamano y ninguna): debe ocultarse y reaparecer con su tamaño y su escala completos",
    Callback = function()
        task.spawn(function()
            local previo = AlanUI.Opciones.AnimacionVentana
            local W = ventanaDePrueba("Prueba de minimizar", { GuardarPosicion = false })
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            for i = 1, 40 do sec:Toggle({ Texto = "Toggle " .. i, Flag = "vt_mm_" .. i, Defecto = false }) end
            task.wait(1.4)
            local main = W._main
            local escala = main and main:FindFirstChildOfClass("UIScale")
            local partes, todo = {}, main ~= nil
            for _, modo in ipairs({ "fantasma", "tamano", "ninguna" }) do
                AlanUI.Opciones.AnimacionVentana = modo
                local tamanoAntes, escalaAntes = main.Size, escala and escala.Scale
                W:Minimizar()
                task.wait(0.8)
                local oculta = main.Visible == false and W:EstaVisible() == false
                W:Mostrar()
                task.wait(0.9)
                local visible = main.Visible == true and W:EstaVisible() == true
                local tamanoIgual = main.Size == tamanoAntes
                local escalaOk = escala ~= nil and escalaAntes ~= nil and math.abs(escala.Scale - escalaAntes) < 0.01
                local ok = oculta and visible and tamanoIgual and escalaOk
                todo = todo and ok
                partes[#partes + 1] = ok and (modo .. ": ok")
                    or (" %s: oculta %s · reaparece %s · mismo tamaño %s · escala %s"):format(modo, tostring(oculta), tostring(visible), tostring(tamanoIgual), tostring(escalaOk))
            end
            AlanUI.Opciones.AnimacionVentana = previo
            W:Destruir()
            veredicto("Minimizar y Mostrar", todo, " " .. table.concat(partes, " · "))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Rendimiento: FPS al minimizar y mostrar (informativo)",
    Tooltip = "Mide los FPS promedio y el peor fotograma mientras se minimiza y se vuelve a mostrar una ventana pesada (125 controles más la pestaña Preinstalada), en cada modo de AnimacionVentana. Solo informa los números: compáralos entre modos en tu dispositivo",
    Callback = function()
        task.spawn(function()
            local RunService = game:GetService("RunService")
            local previo, previoGlobal = AlanUI.Opciones.AnimacionVentana, AlanUI.Opciones.Animaciones
            AlanUI.Opciones.AnimacionVentana = "auto"
            local W = ventanaDePrueba("Prueba de rendimiento", { PestanaPreinstalada = true, GuardarPosicion = false })
            local sec = W:CrearTab("Carga", "@info"):CrearSeccion("Controles")
            for i = 1, 25 do
                sec:Toggle({ Texto = "T" .. i, Flag = "vt_rf_t" .. i })
                sec:Slider({ Texto = "S" .. i, Flag = "vt_rf_s" .. i, Min = 0, Max = 100, Defecto = 50 })
                sec:Dropdown({ Texto = "D" .. i, Flag = "vt_rf_d" .. i, Opciones = { "A", "B", "C" }, Defecto = "A" })
                sec:Input({ Texto = "I" .. i, Flag = "vt_rf_i" .. i })
                sec:ColorPicker({ Texto = "C" .. i, Flag = "vt_rf_c" .. i, Defecto = Color3.fromRGB(90, 140, 210) })
            end
            task.wait(3)
            -- Devuelve FPS promedio y FPS del peor fotograma durante 'segundos'.
            local function medir(segundos, accion)
                local dts, activo = {}, true
                local conexion = RunService.Heartbeat:Connect(function(dt) if activo then dts[#dts + 1] = dt end end)
                if accion then accion() end
                task.wait(segundos)
                activo = false
                conexion:Disconnect()
                local suma, peor = 0, 0
                for _, dt in ipairs(dts) do
                    suma = suma + dt
                    if dt > peor then peor = dt end
                end
                if #dts == 0 or suma == 0 or peor == 0 then return nil, nil end
                return #dts / suma, 1 / peor
            end
            local reposoProm, reposoMin = medir(1.5)
            local partes, completo = {}, reposoProm ~= nil
            for _, modo in ipairs({ "tamano", "fantasma", "ninguna" }) do
                AlanUI.Opciones.Animaciones = modo
                local cierreProm, cierreMin = medir(0.9, function() W:Minimizar() end)
                local aperturaProm, aperturaMin = medir(1.2, function() W:Mostrar() end)
                completo = completo and cierreProm ~= nil and aperturaProm ~= nil
                partes[#partes + 1] = ("%s: cerrar %.0f/%.0f · abrir %.0f/%.0f"):format(
                    modo, cierreProm or 0, cierreMin or 0, aperturaProm or 0, aperturaMin or 0)
            end
            AlanUI.Opciones.AnimacionVentana, AlanUI.Opciones.Animaciones = previo, previoGlobal
            local objetos = AlanUI:Profiler().ObjetosGui
            W:Destruir()
            veredicto("Rendimiento al minimizar", completo,
                (" objetos de GUI ≈ %s · en reposo %.0f FPS (peor %.0f) · [FPS promedio/peor fotograma] %s"):format(
                    tostring(objetos), reposoProm or 0, reposoMin or 0, table.concat(partes, " | ")))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Eventos: FlagCambiada, TipoCambiado y RecalcularDerivadosEntorno",
    Tooltip = "Escribir una Flag debe emitir FlagCambiada(flag, valor); forzar un tipo de entorno debe emitir TipoCambiado y RecalcularDerivadosEntorno() debe devolver ese tipo",
    Callback = function()
        local flags, tipos = {}, {}
        local c1 = AlanUI.Eventos.FlagCambiada:Connect(function(flag, valor) flags[#flags + 1] = { flag, valor } end)
        local c2 = AlanUI.Eventos.TipoCambiado:Connect(function(tipo) tipos[#tipos + 1] = tipo end)
        AlanUI.Flags["vt_ev_flag"] = 7
        AlanUI:ForzarTipo("Tablet")
        local recalculado = AlanUI:RecalcularDerivadosEntorno()
        AlanUI:LiberarForzado()
        AlanUI.Flags["vt_ev_flag"] = nil
        c1:Disconnect()
        c2:Disconnect()
        local flagOk = flags[1] ~= nil and flags[1][1] == "vt_ev_flag" and flags[1][2] == 7
        local tipoOk, liberado = false, tipos[#tipos] ~= nil and tipos[#tipos] == AlanUI.Capacidades.Tipo
        for _, t in ipairs(tipos) do if t == "Tablet" then tipoOk = true end end
        veredicto("Eventos y entorno", flagOk and tipoOk and recalculado == "Tablet" and liberado,
            (" FlagCambiada(flag, valor): %s · TipoCambiado('Tablet'): %s · RecalcularDerivadosEntorno devolvió Tablet: %s · LiberarForzado emite el tipo real: %s"):format(
                tostring(flagOk), tostring(tipoOk), tostring(recalculado == "Tablet"), tostring(liberado)))
    end })

SPruebas:Boton({ Texto = "✔ Historial: PuedeDeshacer y PuedeRehacer",
    Tooltip = "Cambia una Flag y comprueba que se puede deshacer; deshace y comprueba que se puede rehacer; rehace y vuelve a poder deshacer",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de historial", { GuardarPosicion = false })
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            sec:Toggle({ Texto = "Hist", Flag = "vt_hist", Defecto = false })
            task.wait(0.5)
            AlanUI:LimpiarHistorial()
            local vacio = AlanUI:PuedeDeshacer() == false and AlanUI:PuedeRehacer() == false
            AlanUI.Flags["vt_hist"] = true
            task.wait(0.2)
            local puedeDeshacer = AlanUI:PuedeDeshacer() == true and AlanUI:PuedeRehacer() == false
            AlanUI:Deshacer()
            task.wait(0.2)
            local volvio = AlanUI.Elementos["vt_hist"].Get() == false
            local puedeRehacer = AlanUI:PuedeDeshacer() == false and AlanUI:PuedeRehacer() == true
            AlanUI:Rehacer()
            task.wait(0.2)
            local rehecho = AlanUI.Elementos["vt_hist"].Get() == true and AlanUI:PuedeDeshacer() == true and AlanUI:PuedeRehacer() == false
            W:Destruir()
            AlanUI:LimpiarHistorial()
            veredicto("Historial", vacio and puedeDeshacer and volvio and puedeRehacer and rehecho,
                (" vacío al limpiar: %s · tras un cambio se puede deshacer: %s · deshacer vuelve el valor: %s · luego se puede rehacer: %s · rehacer lo restaura: %s"):format(
                    tostring(vacio), tostring(puedeDeshacer), tostring(volvio), tostring(puedeRehacer), tostring(rehecho)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Registro: Registrar, RegistrarInstancia, RegistrarDibujo y DesconectarYLimpiar",
    Tooltip = "Una instancia registrada con un tema cambia de color al cambiar de tema; una instancia (con padre) y un dibujo registrados se destruyen con la ventana; una conexión pasada a DesconectarYLimpiar queda desconectada",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de registro", { GuardarPosicion = false })
            task.wait(2.2) -- deja terminar la restauración del tema guardado de la ventana nueva
            local marco = Instance.new("Frame")
            marco.Parent = W._main
            AlanUI:Registrar(marco, "BackgroundColor3", "Accent")
            AlanUI.ThemeManager:AplicarTema("Blanco")
            task.wait(0.7)
            -- Un tween de Color3 puede terminar a una millonésima del destino: se compara con tolerancia.
            local function casiIgual(a, b) return math.abs(a.R - b.R) < 0.004 and math.abs(a.G - b.G) < 0.004 and math.abs(a.B - b.B) < 0.004 end
            local obtenidoBlanco = marco.BackgroundColor3
            local temaOk = casiIgual(obtenidoBlanco, AlanUI.ThemeManager.Temas.Blanco.Accent)
            AlanUI.ThemeManager:AplicarTema("Negro")
            task.wait(0.7)
            local volvioOk = casiIgual(marco.BackgroundColor3, AlanUI.ThemeManager.Temas.Negro.Accent)
            local carpeta = Instance.new("Folder")
            carpeta.Parent = workspace -- RegistrarInstancia solo destruye instancias que tengan padre
            AlanUI:RegistrarInstancia(carpeta)
            local dibujoQuitado = false
            AlanUI:RegistrarDibujo({ Remove = function() dibujoQuitado = true end })
            local conexion = game:GetService("RunService").Heartbeat:Connect(function() end)
            AlanUI:RegistrarConexion(conexion)
            AlanUI:DesconectarYLimpiar(conexion)
            local desconectada = conexion.Connected == false
            W:Destruir()
            task.wait(0.4)
            local instanciaOk = carpeta.Parent == nil
            pcall(function() carpeta:Destroy() end)
            veredicto("Registro", temaOk and volvioOk and instanciaOk and dibujoQuitado and desconectada,
                (" Registrar sigue al tema: %s/%s (Blanco dio %d,%d,%d) · instancia destruida con la ventana: %s · dibujo quitado: %s · conexión desconectada: %s"):format(
                    tostring(temaOk), tostring(volvioOk), math.floor(obtenidoBlanco.R * 255 + 0.5), math.floor(obtenidoBlanco.G * 255 + 0.5), math.floor(obtenidoBlanco.B * 255 + 0.5),
                    tostring(instanciaOk), tostring(dibujoQuitado), tostring(desconectada)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Configuración: GuardarConfiguracion, CargarConfiguracion y ListarUI",
    Tooltip = "Guarda y recarga la configuración de una ventana con su NombreConfig, y comprueba que SM:ListarUI lista un guardado de interfaz recién creado",
    Callback = function()
        task.spawn(function()
            if type(writefile) ~= "function" or type(isfile) ~= "function" then veredicto("Configuración", false, "tu ejecutor no expone writefile/isfile") return end
            local SM = AlanUI.SaveManager
            local W = ventanaDePrueba("Prueba de configuración", { NombreConfig = "vitrina_cfg_v2128", GuardarPosicion = false })
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            sec:Toggle({ Texto = "Cfg", Flag = "vt_cfg_t", Defecto = false })
            task.wait(0.5)
            AlanUI.Elementos["vt_cfg_t"].Set(true)
            local guardo = W:GuardarConfiguracion()
            AlanUI.Elementos["vt_cfg_t"].Set(false)
            local cargo = W:CargarConfiguracion()
            local restaurado = AlanUI.Elementos["vt_cfg_t"].Get() == true
            local guardoUI = SM:GuardarUI("vitrina_ui_v2128")
            local lista = SM:ListarUI()
            local listado = table.find(lista, "vitrina_ui_v2128") ~= nil
            SM:EliminarUI("vitrina_ui_v2128")
            W:Destruir()
            SM:Eliminar("vitrina_cfg_v2128")
            veredicto("Configuración", guardo ~= false and cargo == true and restaurado and guardoUI ~= false and listado,
                (" GuardarConfiguracion: %s · CargarConfiguracion: %s · valor restaurado: %s · ListarUI lo lista: %s"):format(
                    tostring(guardo ~= false), tostring(cargo == true), tostring(restaurado), tostring(listado)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Campos: MaxCaracteres, OcultarContador, Decimales y Prefijo",
    Tooltip = "Un Input y un TagInput recortan el texto a MaxCaracteres; el Input muestra su contador salvo con OcultarContador; un NumberStepper con Decimales y Prefijo muestra «$5.00»",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de campos", { GuardarPosicion = false })
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            local entrada = sec:Input({ Texto = "In1", Flag = "vt_c_in1", MaxCaracteres = 10 })
            local sinContador = sec:Input({ Texto = "In2", Flag = "vt_c_in2", MaxCaracteres = 10, OcultarContador = true })
            local etiquetas = sec:TagInput({ Texto = "Tg", Flag = "vt_c_tag", MaxCaracteres = 5 })
            local paso = sec:NumberStepper({ Texto = "Ns", Flag = "vt_c_ns", Min = 0, Max = 10, Incremento = 1, Defecto = 5, Decimales = 2, Prefijo = "$" })
            task.wait(0.8)
            local function raiz(c) return c and (c.Fila or c.Instancia) end
            local function caja(c)
                local r = raiz(c)
                if not r then return nil end
                for _, d in ipairs(r:GetDescendants()) do if d:IsA("TextBox") then return d end end
            end
            local function contador(c)
                local r = raiz(c)
                if not r then return nil end
                for _, d in ipairs(r:GetDescendants()) do
                    if d:IsA("TextLabel") and d.Text:match("^%d+/%d+$") then return d end
                end
            end
            local c1, c2, c3, c4 = caja(entrada), caja(sinContador), caja(etiquetas), caja(paso)
            if not (c1 and c2 and c3 and c4) then
                W:Destruir()
                veredicto("Campos", false, "no se encontró alguno de los cuadros de texto")
                return
            end
            c1.Text = string.rep("a", 30)
            c2.Text = string.rep("b", 30)
            c3.Text = string.rep("c", 30)
            task.wait(0.5)
            local topeInput = #c1.Text == 10 and #c2.Text == 10
            local topeTag = #c3.Text == 5
            local conContador = contador(entrada) ~= nil
            local seOculta = contador(sinContador) == nil
            local formato = c4.Text:find("$", 1, true) == 1 and c4.Text:find("5.00", 1, true) ~= nil
            W:Destruir()
            veredicto("Campos", topeInput and topeTag and conContador and seOculta and formato,
                (" Input recorta a 10: %s · TagInput recorta a 5: %s · contador visible: %s · OcultarContador lo quita: %s · Stepper muestra «%s»: %s"):format(
                    tostring(topeInput), tostring(topeTag), tostring(conContador), tostring(seOculta), c4.Text, tostring(formato)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Layout: Columnas, Grupo, Imagen, Parrafo y Construir",
    Tooltip = "Columnas con Proporcion 0.3 y Separacion 20; Grupo con AnchoMinimo enorme se apila; Imagen con Escala Stretch; Parrafo con ImagenEscala Fit; Construir arma controles desde una lista",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de layout", { GuardarPosicion = false })
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            local izq, der = sec:Columnas({ Proporcion = 0.3, Separacion = 20, MinimoAncho = 1 })
            local grupo = sec:Grupo({ AnchoMinimo = 5000 })
            grupo:Boton({ Texto = "Uno", Callback = function() end })
            grupo:Boton({ Texto = "Dos", Callback = function() end })
            local imagen = sec:Imagen({ Url = "rbxassetid://6031094678", Escala = "Stretch" })
            local parrafo = sec:Parrafo({ Titulo = "P", Contenido = "Texto", ImagenUrl = "rbxassetid://6031094678", ImagenEscala = "Fit" })
            local construidos = sec:Construir({
                { Control = "Toggle", Texto = "Cn T", Flag = "vt_cn_t", Defecto = true },
                { Tipo = "Slider", Texto = "Cn S", Flag = "vt_cn_s", Min = 0, Max = 10, Defecto = 3 },
            })
            task.wait(1.2)
            local tIzq, tDer = izq.Instancia.Size.X, der.Instancia.Size.X
            local colOk = math.abs(tIzq.Scale - 0.3) < 0.001 and tIzq.Offset == -10 and math.abs(tDer.Scale - 0.7) < 0.001 and tDer.Offset == -10
            local grupoOk = grupo.Instancia.Size.Y.Offset == 72
            local imagenOk = imagen.Instancia.ScaleType == Enum.ScaleType.Stretch
            local imgParrafo
            for _, d in ipairs(parrafo.Instancia:GetDescendants()) do if d:IsA("ImageLabel") then imgParrafo = d break end end
            local parrafoOk = imgParrafo ~= nil and imgParrafo.ScaleType == Enum.ScaleType.Fit
            local construirOk = construidos[1] ~= nil and construidos[2] ~= nil and construidos["vt_cn_s"] == construidos[2]
                and AlanUI.Elementos["vt_cn_s"].Get() == 3 and AlanUI.Elementos["vt_cn_t"].Get() == true
            W:Destruir()
            veredicto("Layout", colOk and grupoOk and imagenOk and parrafoOk and construirOk,
                (" Columnas 0.3/20: %s · Grupo apilado (alto 72): %s · Imagen Stretch: %s · Parrafo Fit: %s · Construir: %s"):format(
                    tostring(colOk), tostring(grupoOk), tostring(imagenOk), tostring(parrafoOk), tostring(construirOk)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Dialogo: MostrarCancelar",
    Tooltip = "Un Dialogo info no trae «Cancelar» por defecto; con MostrarCancelar = true sí; uno question con MostrarCancelar = false no",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de diálogo", { GuardarPosicion = false })
            task.wait(1)
            local function botones(cfg)
                local modal = AlanUI:Dialogo(cfg)
                task.wait(0.6)
                local n = 0
                if modal and modal.Fondo then
                    for _, d in ipairs(modal.Fondo:GetDescendants()) do if d:IsA("TextButton") then n = n + 1 end end
                end
                if modal and modal.Cerrar then modal.Cerrar() end
                task.wait(0.4)
                return n
            end
            local base = botones({ Tipo = "info", Titulo = "Info", Contenido = "Sin cancelar por defecto" })
            local con = botones({ Tipo = "info", Titulo = "Info", Contenido = "Con cancelar", MostrarCancelar = true })
            local sin = botones({ Tipo = "question", Titulo = "Pregunta", Contenido = "Sin cancelar", MostrarCancelar = false })
            W:Destruir()
            veredicto("Dialogo MostrarCancelar", base > 0 and con == base + 1 and sin == base,
                (" botones: info = %d · info con MostrarCancelar = %d · question sin cancelar = %d"):format(base, con, sin))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Ventana: Transparencia, Orientacion, PosicionInicial y tamaño Mini",
    Tooltip = "Crea una ventana con Transparencia 0.3, Orientacion horizontal y PosicionInicial, y una Mini con TamanoMiniX/TamanoMiniY",
    Callback = function()
        task.spawn(function()
            local W = ventanaDePrueba("Prueba de ventana", { Transparencia = 0.3, Orientacion = "horizontal", PosicionInicial = UDim2.new(0.25, 0, 0.35, 0), GuardarPosicion = false })
            task.wait(1)
            local main = W._main
            local transpOk = main ~= nil and math.abs(main.BackgroundTransparency - 0.3) < 0.001
            local posOk = main ~= nil and math.abs(main.Position.X.Scale - 0.25) < 0.001 and math.abs(main.Position.Y.Scale - 0.35) < 0.001
            local horizOk = W._buscadorBoxHoriz ~= nil and W._buscadorBoxHoriz.Visible == true
            W:Destruir()
            task.wait(0.5)
            local W2 = ventanaDePrueba("Prueba Mini", { Mini = true, TamanoMiniX = 300, TamanoMiniY = 220, GuardarPosicion = false })
            task.wait(1.2)
            local m2 = W2._main
            local miniOk = m2 ~= nil and math.abs(m2.Size.X.Offset - 300) < 1 and math.abs(m2.Size.Y.Offset - 220) < 1
            W2:Destruir()
            veredicto("Ventana: parámetros", transpOk and posOk and horizOk and miniOk,
                (" Transparencia 0.3: %s · PosicionInicial: %s · Orientacion horizontal: %s · Mini 300x220: %s"):format(
                    tostring(transpOk), tostring(posOk), tostring(horizOk), tostring(miniOk)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Transparencia también en los controles (Opciones.TransparenciaEnControles)",
    Tooltip = "Con la opción apagada, subir la transparencia de la ventana deja opacas las filas; con la opción encendida las aclara (60% del valor), también a los controles creados después, y al volver a 0 quedan opacas",
    Callback = function()
        task.spawn(function()
            local previo = AlanUI.Opciones.TransparenciaEnControles
            AlanUI.Opciones.TransparenciaEnControles = false
            local W = ventanaDePrueba("Prueba de transparencia", { PestanaPreinstalada = true, GuardarPosicion = false })
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            local t1 = sec:Toggle({ Texto = "Tc1", Flag = "vt_tc1", Defecto = false })
            task.wait(1)
            local slider = AlanUI.Elementos["sys_transparencia"]
            if not slider then
                AlanUI.Opciones.TransparenciaEnControles = previo
                W:Destruir()
                veredicto("Transparencia en controles", false, "no se encontró el slider de transparencia de la Preinstalada")
                return
            end
            slider.Set(50, true)
            task.wait(0.2)
            local apagada = t1.Fila.BackgroundTransparency == 0 and math.abs(W._main.BackgroundTransparency - 0.5) < 0.001
            AlanUI.Opciones.TransparenciaEnControles = true
            slider.Set(40, true)
            task.wait(0.2)
            local encendida = math.abs(t1.Fila.BackgroundTransparency - 0.24) < 0.001
            local t2 = sec:Toggle({ Texto = "Tc2", Flag = "vt_tc2", Defecto = false })
            task.wait(0.4)
            local nuevo = math.abs(t2.Fila.BackgroundTransparency - 0.24) < 0.001
            slider.Set(0, true)
            task.wait(0.2)
            local alVolver = t1.Fila.BackgroundTransparency == 0 and t2.Fila.BackgroundTransparency == 0
            AlanUI.Opciones.TransparenciaEnControles = previo
            W:Destruir()
            veredicto("Transparencia en controles", apagada and encendida and nuevo and alVolver,
                (" opción apagada deja la fila opaca: %s · encendida (40%% → 24%%): %s · control creado después: %s · a 0 vuelve opaca: %s"):format(
                    tostring(apagada), tostring(encendida), tostring(nuevo), tostring(alVolver)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Animaciones: fantasma, tamano y ninguna",
    Tooltip = "Mide cuántos tamaños intermedios recorre la ventana. «ninguna»: relleno del slider y cambio de alto instantáneos. «fantasma»: el cambio de alto de una ventana pesada es instantáneo pero el cambio de modo (con el contenido oculto) se anima. «tamano»: todo se anima",
    Callback = function()
        task.spawn(function()
            local RunService = game:GetService("RunService")
            local previoGlobal, previoVentana = AlanUI.Opciones.Animaciones, AlanUI.Opciones.AnimacionVentana
            AlanUI.Opciones.AnimacionVentana = "auto"
            local resultados, todo = {}, true
            for _, modo in ipairs({ "tamano", "fantasma", "ninguna" }) do
                AlanUI.Opciones.Animaciones = modo
                local W = ventanaDePrueba("Prueba de animaciones", { PestanaPreinstalada = true, PermiteAlternarModo = true, GuardarPosicion = false })
                local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
                local slider = sec:Slider({ Texto = "An", Flag = "vt_an_s", Min = 0, Max = 100, Defecto = 50 })
                for i = 1, 40 do sec:Toggle({ Texto = "Toggle " .. i, Flag = "vt_an_" .. i, Defecto = false }) end
                task.wait(2)
                local main = W._main
                local function hayRelleno(valor)
                    for _, d in ipairs(slider.Fila:GetDescendants()) do
                        if d:IsA("Frame") and d.Size.Y.Scale == 1 and math.abs(d.Size.X.Scale - valor) < 0.001 then return true end
                    end
                    return false
                end
                -- Registra el tamaño de la ventana en cada fotograma mientras dura 'accion'.
                -- Devuelve cuántos tamaños intermedios recorrió y si el tamaño final cambió.
                local function medirTamano(accion, segundos)
                    local inicial, muestras, activo = main.Size, {}, true
                    local conexion = RunService.Heartbeat:Connect(function() if activo then muestras[#muestras + 1] = main.Size end end)
                    accion()
                    task.wait(segundos)
                    activo = false
                    conexion:Disconnect()
                    local final = muestras[#muestras] or inicial
                    local intermedios = 0
                    for _, t in ipairs(muestras) do
                        local deInicio = math.abs(t.X.Offset - inicial.X.Offset) > 0.5 or math.abs(t.Y.Offset - inicial.Y.Offset) > 0.5
                        local deFinal = math.abs(t.X.Offset - final.X.Offset) > 0.5 or math.abs(t.Y.Offset - final.Y.Offset) > 0.5
                        if deInicio and deFinal then intermedios = intermedios + 1 end
                    end
                    local cambio = math.abs(final.X.Offset - inicial.X.Offset) > 0.5 or math.abs(final.Y.Offset - inicial.Y.Offset) > 0.5
                    return intermedios, cambio
                end
                slider.Set(80)
                local relleno = hayRelleno(0.8)
                task.wait(0.6)
                local rellenoFinal = hayRelleno(0.8)
                local altoIntermedios, altoCambio = medirTamano(function() AlanUI.Elementos["sys_alto"].Set(80, true) end, 1.2)
                local modoIntermedios, modoCambio = medirTamano(function() W:CambiarModo("mini") end, 2)
                -- Una animación real recorre muchos tamaños (4 o más); un cambio instantáneo puede
                -- dejar uno o dos (el cambio de modo se aplica en dos pasos seguidos).
                local ANIMADO, INSTANTANEO = 4, 2
                local ok = rellenoFinal and altoCambio and modoCambio
                if modo == "tamano" then ok = ok and (not relleno) and altoIntermedios >= ANIMADO and modoIntermedios >= ANIMADO
                elseif modo == "fantasma" then ok = ok and (not relleno) and altoIntermedios <= INSTANTANEO and modoIntermedios >= ANIMADO
                else ok = ok and relleno and altoIntermedios <= INSTANTANEO and modoIntermedios <= INSTANTANEO end
                todo = todo and ok
                resultados[#resultados + 1] = ("%s: relleno instantáneo %s · tamaños intermedios al cambiar el alto %d · al cambiar de modo %d%s"):format(
                    modo, tostring(relleno), altoIntermedios, modoIntermedios, ok and "" or " ✖")
                W:Destruir()
                task.wait(0.5)
            end
            AlanUI.Opciones.Animaciones, AlanUI.Opciones.AnimacionVentana = previoGlobal, previoVentana
            veredicto("Animaciones", todo, " " .. table.concat(resultados, " · "))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Temas: derivado de un color y AutoContraste",
    Tooltip = "AplicarTema(Color3) arma un tema oscuro con ese acento y AplicarTema({ Base, Claro = true }) uno claro, ambos con texto legible; con AutoContraste un tema de texto borroso pasa a contraste 4.5:1",
    Callback = function()
        local TM, Theme = AlanUI.ThemeManager, AlanUI.Theme
        local function casi(a, b) return math.abs(a.R - b.R) < 0.004 and math.abs(a.G - b.G) < 0.004 and math.abs(a.B - b.B) < 0.004 end
        local function lum(c)
            local function k(v) return v <= 0.03928 and v / 12.92 or ((v + 0.055) / 1.055) ^ 2.4 end
            return 0.2126 * k(c.R) + 0.7152 * k(c.G) + 0.0722 * k(c.B)
        end
        local function contraste(a, b)
            local la, lb = lum(a), lum(b)
            if la < lb then la, lb = lb, la end
            return (la + 0.05) / (lb + 0.05)
        end
        local base = Color3.fromRGB(200, 60, 90)
        TM:AplicarTema(base)
        local oscuroOk = casi(Theme.Accent, base) and lum(Theme.Background) < 0.2 and contraste(Theme.Text, Theme.Fila) >= 4.5
        TM:AplicarTema({ Base = base, Claro = true })
        local claroOk = casi(Theme.Accent, base) and lum(Theme.Background) > 0.5 and contraste(Theme.Text, Theme.Fila) >= 4.5
        local tema = {}
        for clave, valor in pairs(TM.Temas.Negro) do tema[clave] = valor end
        tema.Background, tema.Panel, tema.Fila = Color3.fromRGB(128, 128, 128), Color3.fromRGB(128, 128, 128), Color3.fromRGB(128, 128, 128)
        tema.Text, tema.TextDark = Color3.fromRGB(140, 140, 140), Color3.fromRGB(150, 150, 150)
        TM:AgregarTema("VitContraste", tema)
        local previo = AlanUI.Opciones.AutoContraste
        AlanUI.Opciones.AutoContraste = false
        TM:AplicarTema("VitContraste")
        local sinOpcion = contraste(Theme.Text, Theme.Fila) < 4.5
        AlanUI.Opciones.AutoContraste = true
        TM:AplicarTema("VitContraste")
        local conOpcion = contraste(Theme.Text, Theme.Fila) >= 4.5 and contraste(Theme.TextDark, Theme.Panel) >= 4.5
        AlanUI.Opciones.AutoContraste = previo
        TM:AplicarTema("Negro")
        veredicto("Temas derivados y AutoContraste", oscuroOk and claroOk and sinOpcion and conOpcion,
            (" Color3 → tema oscuro legible: %s · {Base, Claro} → tema claro legible: %s · sin AutoContraste el texto borroso queda: %s · con AutoContraste llega a 4.5:1: %s"):format(
                tostring(oscuroOk), tostring(claroOk), tostring(sinOpcion), tostring(conOpcion)))
    end })

SPruebas:Boton({ Texto = "✔ Indicador de guardado (Opciones.IndicadorGuardado)",
    Tooltip = "Con la opción activa, cambiar un control pone el puntito de la barra de título en ámbar, tras el autoguardado (hasta 10 s) en verde y unos segundos después vuelve a gris. Tarda unos 17 segundos",
    Callback = function()
        task.spawn(function()
            local previo = AlanUI.Opciones.IndicadorGuardado
            AlanUI.Opciones.IndicadorGuardado = true
            local W = ventanaDePrueba("Prueba de indicador", { NombreConfig = "vitrina_ind_v2130", AutoGuardar = true, GuardarPosicion = false })
            local sec = W:CrearTab("Prueba", "@info"):CrearSeccion("Controles")
            sec:Toggle({ Texto = "Ind", Flag = "vt_ind", Defecto = false })
            task.wait(1.2)
            local Theme = AlanUI.Theme
            local function casi(a, b) return math.abs(a.R - b.R) < 0.004 and math.abs(a.G - b.G) < 0.004 and math.abs(a.B - b.B) < 0.004 end
            local punto = W._main:FindFirstChild("IndicadorGuardado", true)
            if not punto then
                AlanUI.Opciones.IndicadorGuardado = previo
                W:Destruir()
                veredicto("Indicador de guardado", false, "no se creó el puntito en la barra de título")
                return
            end
            AlanUI.Elementos["vt_ind"].Set(true, true)
            task.wait(0.6)
            local ambar = casi(punto.BackgroundColor3, Theme.Aviso)
            local verde = false
            for _ = 1, 24 do
                task.wait(0.5)
                if casi(punto.BackgroundColor3, Theme.Exito) then verde = true break end
            end
            local gris = false
            if verde then
                task.wait(2.8)
                gris = casi(punto.BackgroundColor3, Theme.Apagado)
            end
            AlanUI.Opciones.IndicadorGuardado = previo
            W:Destruir()
            pcall(function() AlanUI.SaveManager:Eliminar("vitrina_ind_v2130") end)
            veredicto("Indicador de guardado", gris and ambar and verde,
                (" ámbar con cambio pendiente: %s · verde tras el autoguardado: %s · vuelve a gris: %s"):format(tostring(ambar), tostring(verde), tostring(gris)))
        end)
    end })

SPruebas:Boton({ Texto = "✔ Capacidades: protección de la GUI, archivos completos, portapapeles y navegación",
    Tooltip = "Las capacidades detectadas deben coincidir con lo que el ejecutor expone: ProtectGUI incluye gethui y sus alias; ArchivosCompletos pide isfile, isfolder, makefolder, delfile y listfiles; Portapapeles acepta los alias de setclipboard; las Features las reflejan",
    Callback = function()
        local C = AlanUI.Capacidades
        local function es(f) return type(f) == "function" end
        local protegido = (type(syn) == "table" and es(syn.protect_gui)) or es(protectgui) or es(gethui) or es(get_hidden_gui) or es(gethiddengui)
        local hui = es(gethui) or es(get_hidden_gui) or es(gethiddengui)
        local completos = es(writefile) and es(readfile) and es(isfile) and es(isfolder) and es(makefolder) and es(delfile) and es(listfiles)
        local portapapeles = es(setclipboard) or es(toclipboard) or es(set_clipboard)
        local RunService, UserInputService = game:GetService("RunService"), game:GetService("UserInputService")
        local okEntorno = C.EsStudio == RunService:IsStudio() and C.TieneTouch == UserInputService.TouchEnabled
            and C.TieneMouse == UserInputService.MouseEnabled and type(C.Tipo) == "string"
            and C.EsTactil == (C.Tipo == "Movil" or C.Tipo == "Tablet")
            and C.EsEscritorio == (C.Tipo == "PC" or C.Tipo == "Consola")
            and C.EsTouchOnly == (C.TieneTouch and not C.TieneMouse and not C.Teclado)
        local okCapacidades = C.ProtectGUI == protegido and C.GetHUI == hui and C.ArchivosCompletos == completos
            and C.Portapapeles == portapapeles and type(C.NavegacionGamepad) == "boolean" and okEntorno
        local function soporte(nombre) return AlanUI:VerificarSoporte(nombre).ok end
        local okFeatures = soporte("ProtectGUI") == C.ProtectGUI and soporte("ArchivosCompletos") == C.ArchivosCompletos
            and soporte("SetClipboard") == C.Portapapeles
        local okCopiar = (AlanUI._copiarPortapapeles ~= nil) == C.Portapapeles
        veredicto("Capacidades", okCapacidades and okFeatures and okCopiar,
            (" ProtectGUI=%s (gethui=%s) · ArchivosCompletos=%s · Portapapeles=%s · NavegacionGamepad=%s · entorno (%s, touch=%s, mouse=%s) coherente: %s · coinciden con el ejecutor: %s · las Features las reflejan: %s · función de copiado resuelta: %s"):format(
                tostring(C.ProtectGUI), tostring(C.GetHUI), tostring(C.ArchivosCompletos), tostring(C.Portapapeles), tostring(C.NavegacionGamepad),
                tostring(C.Tipo), tostring(C.TieneTouch), tostring(C.TieneMouse), tostring(okEntorno),
                tostring(okCapacidades), tostring(okFeatures), tostring(okCopiar)))
    end })

SPruebas:Boton({ Texto = "✔ Carga de la librería: método usado",
    Tooltip = "La vitrina publicada debe cargar la librería con loadstring(game:HttpGet(url)) (o loadstring con request si no hay game:HttpGet). Con getgenv().ALANUI_LOCAL = true usa readfile y la prueba avisa de que es modo desarrollo",
    Callback = function()
        local f = CARGA.Funciones
        local publicado = CARGA.Metodo == "loadstring(game:HttpGet(url))" or CARGA.Metodo == "loadstring(request(url).Body)"
        local cargada = type(AlanUI) == "table" and type(AlanUI.Version) == "string"
        veredicto("Carga de la librería", cargada and f.loadstring and (publicado or CARGA.Desarrollo),
            (" método: %s%s · AlanUI %s · funciones detectadas: loadstring=%s, game:HttpGet=%s, request=%s, readfile=%s · URL: %s"):format(
                CARGA.Metodo, CARGA.Desarrollo and " (modo desarrollo: no usar al publicar)" or "", tostring(AlanUI.Version),
                tostring(f.loadstring), tostring(f.HttpGet), tostring(f.request), tostring(f.readfile), CARGA.URL))
    end })

SPruebas:Boton({ Texto = "✔ AlanUI.Animaciones: Fade, Slide, Scale y Bounce",
    Tooltip = "Los cuatro ayudantes públicos de animación: llevan un objeto a su destino (Bounce lo agranda un poco y lo devuelve a su tamaño) y, como pasan por Utils.Tween, con Opciones.Animaciones = «ninguna» aplican al instante",
    Callback = function()
        task.spawn(function()
            local previo = AlanUI.Opciones.Animaciones
            AlanUI.Opciones.Animaciones = "tamano"
            local W = ventanaDePrueba("Prueba de animaciones", { GuardarPosicion = false })
            task.wait(1)
            local A = AlanUI.Animaciones
            local marco = Instance.new("Frame")
            marco.Size, marco.Position, marco.BackgroundTransparency = UDim2.new(0, 100, 0, 80), UDim2.new(0.5, 0, 0.5, 0), 0
            marco.Parent = W._main
            local function casi(a, b) return math.abs(a - b) < 0.01 end
            A.Fade(marco, 0.5, 0.2)
            A.Slide(marco, UDim2.new(0.3, 0, 0.4, 0), 0.2)
            A.Scale(marco, UDim2.new(0, 50, 0, 40), 0.2)
            task.wait(0.6)
            local fadeOk = casi(marco.BackgroundTransparency, 0.5)
            local slideOk = casi(marco.Position.X.Scale, 0.3) and casi(marco.Position.Y.Scale, 0.4)
            local scaleOk = marco.Size == UDim2.new(0, 50, 0, 40)
            A.Bounce(marco, UDim2.new(0, 80, 0, 60), 0.3)
            task.wait(0.7)
            local bounceOk = marco.Size == UDim2.new(0, 80, 0, 60)
            AlanUI.Opciones.Animaciones = "ninguna"
            A.Fade(marco, 0.2, 0.5)
            local instantaneo = casi(marco.BackgroundTransparency, 0.2)
            AlanUI.Opciones.Animaciones = previo
            marco:Destroy()
            W:Destruir()
            veredicto("AlanUI.Animaciones", fadeOk and slideOk and scaleOk and bounceOk and instantaneo,
                (" Fade: %s · Slide: %s · Scale: %s · Bounce vuelve a su tamaño: %s · con «ninguna» aplica al instante: %s"):format(
                    tostring(fadeOk), tostring(slideOk), tostring(scaleOk), tostring(bounceOk), tostring(instantaneo)))
        end)
    end })

-- ── Estilo visual: muestras clásica y moderna ──────────────────
local SEstilo = TabFugas:CrearSeccion("Estilo visual")
SEstilo:Parrafo({ Titulo = "Opciones.EstiloVisual", Contenido = "«clasico» es el aspecto de siempre; «moderno» cambia solo lo visual: «?» tenue, X de cerrar gris (roja al pasar el cursor o tocarla), pestaña activa más marcada, buscador con lupa vectorial, estados con punto de color en vez de emojis y más aire entre secciones. Esta vitrina usa «" .. ESTILO_VISUAL .. "». En el moderno la pestaña activa es una píldora completa. Los botones abren una ventana de muestra y reemplazan esta; re-ejecuta la vitrina para volver." })

local function abrirMuestraEstilo(estilo)
    task.spawn(function()
        local W = AlanUI:CrearVentana({
            Titulo = "Muestra " .. estilo, Subtitulo = "Estilo visual", TamanoX = TAMANO_X, TamanoY = TAMANO_Y,
            Buscador = true, AutoGuardar = false, NombreConfig = "vitrina_estilo",
            EstiloVisual = estilo, PestanaPreinstalada = false,
        })
        local sec = W:CrearTab("Controles", "@configuracion"):CrearSeccion("Filas con ayuda")
        sec:Toggle({ Texto = "Activar opción", Flag = "ve_t", Defecto = false, Tooltip = "En el estilo moderno el «?» es tenue y se enciende al pasar el cursor" })
        sec:Slider({ Texto = "Velocidad", Flag = "ve_s", Min = 0, Max = 100, Defecto = 50, Sufijo = "%", Tooltip = "Mismo control, mismo comportamiento: solo cambia el aspecto" })
        sec:Label({ Texto = "Ejecutor", Valor = "Arceus X", Tooltip = "El valor de la derecha no se aprieta con el «?»" })
        sec:Boton({ Texto = "Cerrar la muestra", Callback = function() W:Destruir() end })
        W:CrearTab("Otra pestaña", "@info"):CrearSeccion("Contenido"):Label({ Texto = "Pestaña", Valor = "Segunda" })
        -- El módulo Sistema trae los estados (rendimiento, salud, funciones): con punto de color o con emoji.
        W:AgregarModuloPreinstalado(W:CrearTab("Sistema", "@preinstalada"), "Sistema")
    end)
end
for _, estilo in ipairs({ "clasico", "moderno" }) do
    SEstilo:Boton({ Texto = "🎨 Abrir muestra «" .. estilo .. "» (reemplaza esta ventana)",
        Callback = function()
            AlanUI:Confirmar({ Titulo = "¿Abrir la muestra " .. estilo .. "?", Contenido = "La vitrina se cierra. Re-ejecútala para volver.", Icono = "⚠️",
                BotonAceptar = { Texto = "Abrir", Callback = function() abrirMuestraEstilo(estilo) end },
                BotonCancelar = { Texto = "Cancelar" } })
        end })
end

-- ── API del modo Mini y módulos de la Preinstalada ─────────────
local SMiniCompleto = TabFugas:CrearSeccion("Mini: en esta ventana (modo completo)")
SMiniCompleto:Parrafo({ Titulo = "Sin efecto en modo completo", Contenido = "Plegar, Desplegar, AlternarPliegue, EstaPlegada y CambiarEscalaMini solo actúan en una ventana Mini. Aquí no deben hacer nada ni dar error." })
SMiniCompleto:Boton({ Texto = "✔ API de Mini en modo completo (no-op)",
    Callback = function()
        local ok = pcall(function() V:Plegar(); V:Desplegar(); V:AlternarPliegue() end)
        local pregunta = V:EstaPlegada() == false
        local escala = V:CambiarEscalaMini(1) == false
        veredicto("API de Mini en modo completo", ok and pregunta and escala,
            ("sin error: %s · EstaPlegada()=false: %s · CambiarEscalaMini()=false: %s"):format(tostring(ok), tostring(pregunta), tostring(escala)))
    end })
SMiniCompleto:Boton({ Texto = "✔ AgregarModuloPreinstalado: argumentos inválidos",
    Tooltip = "La Preinstalada de esta ventana ya trae todos los módulos, así que aquí solo se prueban los rechazos: pestaña inválida, módulo inexistente y módulo ya creado",
    Callback = function()
        local r1, r2, r3
        local capt = capturarWarn(function()
            r1 = V:AgregarModuloPreinstalado(nil, "Perfiles")
            r2 = V:AgregarModuloPreinstalado(TabFugas, "NoExiste")
            r3 = V:AgregarModuloPreinstalado(TabFugas, "Perfiles")
        end)
        veredicto("AgregarModuloPreinstalado (rechazos)", r1 == nil and r2 == nil and r3 == nil,
            ("devolvieron nil: %s · avisos capturados: %d"):format(tostring(r1 == nil and r2 == nil and r3 == nil), #capt))
    end })

SMiniCompleto:Boton({ Texto = "✔ CambiarModo / ObtenerModo en ventana no alternable",
    Tooltip = "Esta ventana se creó sin Mini ni PermiteAlternarModo: ObtenerModo() debe decir \"completo\" y CambiarModo() debe rechazar el cambio (false) con un aviso",
    Callback = function()
        local rMini, rBasura
        local capt = capturarWarn(function()
            rMini = V:CambiarModo("mini")
            rBasura = V:CambiarModo("xyz")
        end)
        veredicto("CambiarModo en ventana no alternable", V:ObtenerModo() == "completo" and rMini == false and rBasura == false,
            ("ObtenerModo()=completo: %s · CambiarModo('mini')=false: %s · modo inválido=false: %s · avisos: %d")
                :format(tostring(V:ObtenerModo() == "completo"), tostring(rMini == false), tostring(rBasura == false), #capt))
    end })

local SMiniAbrir = TabFugas:CrearSeccion("Mini: ventana de prueba")
SMiniAbrir:Parrafo({ Titulo = "Qué abre", Contenido = "Una ventana Mini con EscalaMini, AlturaMaximaMini, BordesArrastrables, AutoCargar = false, PestanaPreinstalada = false y TamanoXCompleto/TamanoYCompleto (640×380). Trae botones para Plegar, Desplegar, AlternarPliegue, EstaPlegada, CambiarEscalaMini, AgregarModuloPreinstalado y CambiarModo/ObtenerModo, más autotests. Reemplaza esta ventana; re-ejecuta la vitrina para volver." })

local function abrirMiniDePrueba(plegadoInicial)
    task.spawn(function()
        local M = AlanUI:CrearVentana({
            Titulo = "Vitrina Mini", Mini = true, AutoGuardar = false, NombreConfig = "vitrina_mini",
            EscalaMini = 0.9, AlturaMaximaMini = 360, BordesArrastrables = true,
            AutoCargar = false, Plegado = plegadoInicial == true, PestanaPreinstalada = false,
            TamanoXCompleto = TAMANO_X, TamanoYCompleto = TAMANO_Y,
        })
        local tab = M:CrearTab("Principal", "@configuracion")
        local sec = tab:CrearSeccion("Controles", { Colapsable = false })
        sec:Toggle({ Texto = "Activar", Flag = "vm_t", Defecto = false })
        sec:Slider({ Texto = "Velocidad", Flag = "vm_s", Min = 0, Max = 100, Defecto = 50 })
        sec:Dropdown({ Texto = "Método", Flag = "vm_d", Opciones = { "Tween", "CFrame" }, Defecto = "Tween" })

        local api = tab:CrearSeccion("API de Mini")
        local lblEstado = api:Label({ Texto = "EstaPlegada()", Valor = tostring(M:EstaPlegada()) })
        local function refrescarEstado()
            task.delay(AlanUI.Motion.Page + 0.15, function() pcall(function() lblEstado:Set(tostring(M:EstaPlegada())) end) end)
        end
        api:Boton({ Texto = "Plegar()", Callback = function() M:Plegar() refrescarEstado() end })
        api:Boton({ Texto = "Desplegar()", Callback = function() M:Desplegar() refrescarEstado() end })
        api:Boton({ Texto = "AlternarPliegue()", Callback = function() M:AlternarPliegue() refrescarEstado() end })
        api:Boton({ Texto = "CambiarEscalaMini(0.7)", Callback = function() M:CambiarEscalaMini(0.7) end })
        api:Boton({ Texto = "CambiarEscalaMini(1.1)", Callback = function() M:CambiarEscalaMini(1.1) end })
        api:Boton({ Texto = "CambiarEscalaMini(nil) → automática", Callback = function() M:CambiarEscalaMini(nil) end })
        api:Boton({ Texto = "AgregarModuloPreinstalado(tab, 'Perfiles')", Callback = function()
            local r = M:AgregarModuloPreinstalado(tab, "Perfiles")
            AlanUI:Notificar({ Titulo = "Módulo Perfiles", Texto = r and "Agregado a la pestaña" or "Rechazado (ya estaba creado)", Duracion = 3 })
        end })
        api:Boton({ Texto = "▶ Autotest de la API de Mini", Callback = function()
            task.spawn(function()
                local espera = AlanUI.Motion.Page + 0.3
                M:Plegar();          task.wait(espera); local a = M:EstaPlegada() == true
                M:Desplegar();       task.wait(espera); local b = M:EstaPlegada() == false
                M:AlternarPliegue(); task.wait(espera); local c = M:EstaPlegada() == true
                M:AlternarPliegue(); task.wait(espera); local d = M:EstaPlegada() == false
                local e = M:CambiarEscalaMini(0.7) == true
                task.wait(espera)
                M:CambiarEscalaMini(nil)
                refrescarEstado()
                veredicto("Autotest de Mini", a and b and c and d and e,
                    ("Plegar: %s · Desplegar: %s · Alternar→plegada: %s · Alternar→desplegada: %s · Escala: %s")
                        :format(tostring(a), tostring(b), tostring(c), tostring(d), tostring(e)))
            end)
        end })
        local modo = tab:CrearSeccion("Alternar modo (mini ⇄ completo)")
        local lblModo = modo:Label({ Texto = "ObtenerModo()", Valor = tostring(M:ObtenerModo()) })
        local function refrescarModo()
            task.delay(AlanUI.Motion.Hover + AlanUI.Motion.Page + AlanUI.Motion.Expand + 0.3, function()
                pcall(function() lblModo:Set(tostring(M:ObtenerModo())) end)
            end)
        end
        modo:Boton({ Texto = "CambiarModo(\"completo\")", Tooltip = "Debe crecer al tamaño de la vitrina, 640×480 (TamanoXCompleto/TamanoYCompleto) y mostrar barra lateral y Preinstalada según la config", Callback = function() M:CambiarModo("completo") refrescarModo() end })
        modo:Boton({ Texto = "CambiarModo(\"mini\")", Callback = function() M:CambiarModo("mini") refrescarModo() end })
        modo:Boton({ Texto = "▶ Autotest de CambiarModo", Callback = function()
            task.spawn(function()
                local espera = AlanUI.Motion.Hover + AlanUI.Motion.Page + AlanUI.Motion.Expand + 0.6
                local inicial = M:ObtenerModo() == "mini"
                local r1 = M:CambiarModo("completo"); task.wait(espera); local a = r1 == true and M:ObtenerModo() == "completo"
                local r2 = M:CambiarModo("completo"); local b = r2 == false -- ya está en completo
                local r3 = M:CambiarModo("mini");     task.wait(espera); local c = r3 == true and M:ObtenerModo() == "mini"
                local invalido
                capturarWarn(function() invalido = M:CambiarModo("xyz") end)
                local d = invalido == false
                refrescarModo(); refrescarEstado()
                veredicto("Autotest de CambiarModo", inicial and a and b and c and d,
                    ("empezó en mini: %s · →completo: %s · repetir completo=false: %s · →mini: %s · modo inválido=false: %s")
                        :format(tostring(inicial), tostring(a), tostring(b), tostring(c), tostring(d)))
            end)
        end })
        modo:Boton({ Texto = "Cerrar", Callback = function() M:Destruir() end })
    end)
end

-- Ventana COMPLETA que admite alternar a Mini (PermiteAlternarModo = true).
local function abrirCompletaAlternable()
    task.spawn(function()
        local C = AlanUI:CrearVentana({
            Titulo = "Vitrina alternable", AutoGuardar = false, NombreConfig = "vitrina_alternable",
            PermiteAlternarModo = true, TamanoX = TAMANO_X, TamanoY = TAMANO_Y, PestanaPreinstalada = false,
        })
        local sec = C:CrearTab("Principal", "@configuracion"):CrearSeccion("Controles")
        sec:Toggle({ Texto = "Activar", Flag = "va_t", Defecto = false })
        sec:Slider({ Texto = "Velocidad", Flag = "va_s", Min = 0, Max = 100, Defecto = 50 })
        sec:Toggle({ Texto = "SOLO EN COMPLETO", Flag = "va_t2", Defecto = false, VisibleEnMini = false })
        local lbl = sec:Label({ Texto = "ObtenerModo()", Valor = tostring(C:ObtenerModo()) })
        sec:Boton({ Texto = "CambiarModo(\"mini\")", Callback = function()
            C:CambiarModo("mini")
            task.delay(AlanUI.Motion.Hover + AlanUI.Motion.Page + AlanUI.Motion.Expand + 0.3, function() pcall(function() lbl:Set(tostring(C:ObtenerModo())) end) end)
        end })
        sec:Boton({ Texto = "Cerrar", Callback = function() C:Destruir() end })
    end)
end

SMiniAbrir:Boton({ Texto = "📱 Abrir Mini de prueba (reemplaza esta ventana)",
    Callback = function()
        AlanUI:Confirmar({ Titulo = "¿Abrir la Mini de prueba?", Contenido = "La vitrina se cierra. Re-ejecútala para volver.", Icono = "⚠️",
            BotonAceptar = { Texto = "Abrir", Callback = function() abrirMiniDePrueba(false) end },
            BotonCancelar = { Texto = "Cancelar" } })
    end })
SMiniAbrir:Boton({ Texto = "🖥️ Abrir completa alternable (PermiteAlternarModo = true)",
    Tooltip = "Nace en modo completo pero puede pasar a Mini con CambiarModo('mini'). Los controles con VisibleEnMini = false deben desaparecer al pasar a Mini",
    Callback = function()
        AlanUI:Confirmar({ Titulo = "¿Abrir la ventana alternable?", Contenido = "La vitrina se cierra. Re-ejecútala para volver.", Icono = "⚠️",
            BotonAceptar = { Texto = "Abrir", Callback = abrirCompletaAlternable },
            BotonCancelar = { Texto = "Cancelar" } })
    end })
SMiniAbrir:Boton({ Texto = "📱 Abrir Mini ya plegada (Plegado = true)",
    Tooltip = "Debe nacer solo con el encabezado. Pulsa el título o Desplegar() para abrirla",
    Callback = function()
        AlanUI:Confirmar({ Titulo = "¿Abrir la Mini plegada?", Contenido = "La vitrina se cierra. Re-ejecútala para volver.", Icono = "⚠️",
            BotonAceptar = { Texto = "Abrir", Callback = function() abrirMiniDePrueba(true) end },
            BotonCancelar = { Texto = "Cancelar" } })
    end })

-- ══════════════════════════════════════════════════════════════
--  Estado inicial
-- ══════════════════════════════════════════════════════════════
if esPrimera then
    task.delay(1.2, function()
        AlanUI:Notificar({
            Titulo = "🎛️ Vitrina cargada",
            Texto = "Incluye la pestaña «Fugas y Mini»: Profiler(true), reporte, avisos y modo Mini",
            Tipo = "Success",
            Duracion = 6,
        })
    end)
end

return { TabFugas = TabFugas }
end

construirVitrina(true)
