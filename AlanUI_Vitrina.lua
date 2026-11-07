-- ══════════════════════════════════════════════════════════════
--  AlanUI_Vitrina.lua
--  Vitrina interactiva de TODAS las características de AlanUI.
--  Cada control aparece con un Tooltip explicando qué prueba.
-- ══════════════════════════════════════════════════════════════

-- Asegúrate de tener ambos archivos en la misma carpeta de tu ejecutor
local AlanUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/alanbeikers9/AlanUI/refs/heads/main/AlanUI.lua"))()

-- Iconos propios activos para la pestaña Preinstalada y los Dialogo() por tipo.
AlanUI.Opciones.IconosPropios = true

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
    Tooltip = "Slider estándar con incrementos de 5" })

SNum:Slider({ Texto = "FOV con marcas", Flag = "v_sliderPasos", Min = 70, Max = 120, Incremento = 10, Defecto = 90, Pasos = true,
    Tooltip = "Pasos = true dibuja marcas visuales en cada múltiplo de Incremento" })

SNum:RangeSlider({ Texto = "Distancia (rango)", Flag = "v_range", Min = 0, Max = 200, Incremento = 10, Sufijo = "m", Defecto = { min = 40, max = 150 },
    Tooltip = "Dos manijas: elegís mínimo y máximo al mismo tiempo" })

SNum:NumberStepper({ Texto = "Cantidad exacta", Flag = "v_step", Min = 1, Max = 999, Incremento = 1, Defecto = 10, Sufijo = " pcs",
    Tooltip = "Botones − / + con campo editable. Flechas ↑↓ con el campo enfocado" })

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
    Tooltip = "Dropdown simple: 4 opciones" })

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
    Tooltip = "Click en la cabecera para desplegar los sliders RGB" })

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

local lblAuto = SVis:Label({ Texto = "Label con auto-update", Flag = "v_lblAuto", Valor = "–",
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

SFunc:Boton({ Texto = "🏷️ Agregar tag al header", Callback = function()
    local colores = { "info", "success", "warning", "danger", "neutral" }
    V:AgregarTag({ Texto = "TAG " .. math.random(1, 99), Color = colores[math.random(1, #colores)] })
end })

SFunc:Boton({ Texto = "🌈 Agregar tag rainbow", Callback = function()
    local t = V:AgregarTag({ Texto = "RAINBOW", Color = "rainbow", Icono = "🌈" })
    task.delay(5, function() t.Remover() end)
end })

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
        local creados = V:ConstruirDesdeSchema({
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

AlanUI.Eventos.HistorialCambiado:Connect(function(nD, nR)
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
SOpc:Boton({ Texto = "☀️ Aplicar tema Blanco", Tooltip = "Tema claro: con Borde adaptativo activo, los bordes se ven más marcados",
    Callback = function() AlanUI.ThemeManager:AplicarTema("Blanco") end })
SOpc:Boton({ Texto = "🌙 Aplicar tema Negro", Tooltip = "Tema oscuro: con Borde adaptativo activo, los bordes se ven más sutiles",
    Callback = function() AlanUI.ThemeManager:AplicarTema("Negro") end })
SOpc:Dropdown({ Texto = "Dropdown de prueba (hover)", Flag = "v_opcDropHover", Opciones = { "Uno", "Dos", "Tres" }, Defecto = "Uno",
    Tooltip = "Pasa el cursor por la cabecera: con Micro-interacciones activo la flecha se aclara" })
SOpc:ColorPicker({ Texto = "ColorPicker de prueba (hover)", Flag = "v_opcColorHover", Defecto = Color3.fromRGB(90, 140, 210),
    Tooltip = "Pasa el cursor por la cabecera: con Micro-interacciones activo la muestra gana borde de acento" })

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

SVerif:Slider({ Texto = "Slider con tooltip", Flag = "v_verSlider", Min = 0, Max = 100, Incremento = 1, Defecto = 40,
    Tooltip = "Mantén presionada la manija sin moverla: el tooltip NO debe aparecer. Haz click en cualquier punto de la barra: la manija salta ahí" })
SVerif:RangeSlider({ Texto = "Rango con tooltip", Flag = "v_verRango", Min = 0, Max = 200, Incremento = 10, Defecto = { min = 40, max = 150 },
    Tooltip = "Click en la barra mueve la manija más cercana. Agarrar la manija por arriba o por abajo también debe funcionar" })
SVerif:NumberStepper({ Texto = "Stepper (botones − / +)", Flag = "v_verStepper", Min = 0, Max = 50, Incremento = 1, Defecto = 10,
    Tooltip = "Los botones − y + deben verse grandes y el símbolo bien legible" })
SVerif:Dropdown({ Texto = "Dropdown con aire", Flag = "v_verDrop", Opciones = { "Tween", "CFrame", "Instant", "Safe Jump" }, Defecto = "Tween",
    Tooltip = "Despliega: las opciones deben verse más altas, separadas entre sí y con el texto lejos del borde izquierdo" })
SVerif:Boton({ Texto = "🔔 Lanzar 3 notificaciones", Tooltip = "Cada una debe entrar deslizándose desde la derecha sin saltos, y al salir las demás suben suavemente, sin brincos",
    Callback = function()
        for i = 1, 3 do
            AlanUI:Notificar({ Titulo = "Notificación " .. i, Texto = "Prueba de entrada y salida", Duracion = 2 + i })
        end
    end })
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
SPerf:Boton({ Texto = "🩺 Profiler() sin parámetro (no debe traer Comparacion)",
    Callback = function()
        local d = AlanUI:Profiler()
        veredicto("Profiler() sin true", d.Comparacion == nil, d.Comparacion == nil and "sin Comparacion, como siempre" or "trajo Comparacion")
    end })
SPerf:Boton({ Texto = "📋 DiagnosticoCompleto(true): reporte para soporte",
    Tooltip = "Copia al portapapeles: versión, modo, ejecutor, entorno, features, Profiler y los últimos 5 errores. Si el ejecutor no puede copiar, lo imprime en consola",
    Callback = function()
        local d = AlanUI:DiagnosticoCompleto(true)
        local conOpciones = type(d.Reporte) == "string" and d.Reporte:find("Opciones:", 1, true) ~= nil
            and d.Reporte:find("MaxColaNotificaciones", 1, true) ~= nil
        veredicto("DiagnosticoCompleto(true)", type(d.Reporte) == "string" and #d.Reporte > 0 and type(d.Copiado) == "boolean" and conOpciones,
            ("%d caracteres, copiado: %s, incluye Opciones: %s"):format(#(d.Reporte or ""), tostring(d.Copiado), tostring(conOpciones)))
    end })
SPerf:Boton({ Texto = "📋 DiagnosticoCompleto() sin parámetro (no debe traer Reporte)",
    Callback = function()
        local d = AlanUI:DiagnosticoCompleto()
        veredicto("DiagnosticoCompleto() sin true", d.Reporte == nil and d.Copiado == nil and type(d.FeaturesOk) == "number")
    end })

-- ── Avisos automáticos al crear controles ──────────────────────
local SAvisos = TabFugas:CrearSeccion("Avisos al crear controles")
SAvisos:Parrafo({ Titulo = "Qué prueba", Contenido = "Cada botón crea controles de prueba en la sección de abajo (no se pueden borrar) y revisa que la librería avise por warn() lo que corresponde. Corre una vez por ejecución de la vitrina." })
local SAvisosPrueba = TabFugas:CrearSeccion("Controles de prueba de avisos")
SAvisosPrueba:Parrafo({ Titulo = "Vacía al inicio", Contenido = "Los controles aparecen aquí al pulsar los botones de la sección anterior." })

local avisoDupCorrio, avisoDevCorrio = false, false
SAvisos:Boton({ Texto = "🔁 Flag duplicada → aviso automático",
    Tooltip = "Crea dos Toggle con la misma Flag. Debe haber un warn que avise que el primero deja de ser accesible. Siempre activo, no depende de ModoDev",
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
        if not ok then
            veredicto("Flag duplicada", false, "error al crear: " .. tostring(err))
        elseif #capt == 0 then
            veredicto("Flag duplicada", false, "no se capturó ningún warn (¿tu ejecutor aísla warn? mira la consola)")
        else
            veredicto("Flag duplicada", algunaContiene(capt, "vit_flag_dup", "ya la usa otro control") and elemento ~= nil,
                "el control sigue funcionando y se avisó")
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
    Tooltip = "Debe mostrar «500 m» y pasar a «km» al llegar a 1000. Escribí «1500 km» o «300 m» en la caja: se interpreta bien",
    Sufijo = function(v) return v >= 1000 and " km" or " m" end })
SNuevo:RangeSlider({ Texto = "Rango (Sufijo función)", Flag = "vn_rango", Min = 0, Max = 2000, Incremento = 10, Defecto = { min = 200, max = 1500 },
    Tooltip = "Cada extremo lleva su propio sufijo: «200 m – 1500 km»",
    Sufijo = function(v) return v >= 1000 and " km" or " m" end })
SNuevo:Slider({ Texto = "Sufijo string (como siempre)", Flag = "vn_pct", Min = 0, Max = 100, Defecto = 40, Sufijo = "%" })
local ddPlaceholder = SNuevo:Dropdown({ Texto = "Arma", Flag = "vn_arma", Opciones = { "Espada", "Arco", "Hacha" },
    Placeholder = "Elegí un arma...", Tooltip = "Sin selección debe decir «Arma: Elegí un arma...» en vez de «Ninguno»" })
local ddSinPlaceholder = SNuevo:Dropdown({ Texto = "Sin Placeholder", Flag = "vn_sinph", Opciones = { "A", "B" },
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
                Titulo = ("Test de fugas %d/%d"):format(i, CICLOS), TamanoX = 420, TamanoY = 300,
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
                local W = AlanUI:CrearVentana({ Titulo = titulo, TamanoX = 420, TamanoY = 300, AutoGuardar = false, NombreConfig = "vitrina_doble" })
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
            Titulo = "Resultado: test de fugas", TamanoX = 520, TamanoY = 360,
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

-- Tema Neon
SRonda:Boton({ Texto = "🎨 Aplicar el tema «Neon»",
    Tooltip = "Casi negro, acento rojo neón y texto de alto contraste. También aparece en el selector de temas",
    Callback = function()
        local existe = AlanUI.ThemeManager.Temas and AlanUI.ThemeManager.Temas.Neon ~= nil
        if existe then AlanUI.ThemeManager:AplicarTema("Neon") end
        veredicto("Tema Neon", existe, existe and "aplicado" or "no existe en ThemeManager.Temas")
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

local textoDerivadoCorrio = false
SAudit:Boton({ Texto = "✔ Flag derivada del Texto: aviso de colisión",
    Tooltip = "Crea dos Toggle SIN Flag y con el mismo Texto: ambos usarían el Texto como Flag. Debe haber un warn. Corre una vez por ejecución",
    Callback = function()
        if textoDerivadoCorrio then AlanUI:Notificar({ Titulo = "Flag derivada", Texto = "Ya se corrió. Re-ejecuta la vitrina para repetir", Duracion = 4 }) return end
        textoDerivadoCorrio = true
        local capt = capturarWarn(function()
            SAvisosPrueba:Toggle({ Texto = "Toggle sin Flag (derivada)", Defecto = false })
            SAvisosPrueba:Toggle({ Texto = "Toggle sin Flag (derivada)", Defecto = false })
        end)
        if #capt == 0 then veredicto("Flag derivada del Texto", false, "no se capturó ningún warn (¿tu ejecutor aísla warn? mira la consola)")
        else veredicto("Flag derivada del Texto", algunaContiene(capt, "no tiene Flag", "Toggle sin Flag (derivada)")) end
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

-- ── Estilo visual: muestras clásica y moderna ──────────────────
local SEstilo = TabFugas:CrearSeccion("Estilo visual")
SEstilo:Parrafo({ Titulo = "Opciones.EstiloVisual", Contenido = "«clasico» es el aspecto de siempre; «moderno» cambia solo lo visual: «?» tenue, X de cerrar gris (roja al pasar el cursor o tocarla), pestaña activa más marcada, buscador con lupa vectorial, estados con punto de color en vez de emojis y más aire entre secciones. Esta vitrina usa «" .. ESTILO_VISUAL .. "». En el moderno la pestaña activa es una píldora completa. Los botones abren una ventana de muestra y reemplazan esta; re-ejecuta la vitrina para volver." })

local function abrirMuestraEstilo(estilo)
    task.spawn(function()
        local W = AlanUI:CrearVentana({
            Titulo = "Muestra " .. estilo, Subtitulo = "Estilo visual", TamanoX = 560, TamanoY = 380,
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
            TamanoXCompleto = 640, TamanoYCompleto = 380,
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
        modo:Boton({ Texto = "CambiarModo(\"completo\")", Tooltip = "Debe crecer a 640×380 (TamanoXCompleto/TamanoYCompleto) y mostrar barra lateral y Preinstalada según la config", Callback = function() M:CambiarModo("completo") refrescarModo() end })
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
            PermiteAlternarModo = true, TamanoX = 560, TamanoY = 340, PestanaPreinstalada = false,
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
task.delay(1.2, function()
    AlanUI:Notificar({
        Titulo = "🎛️ Vitrina cargada",
        Texto = "Incluye la pestaña «Fugas y Mini»: Profiler(true), reporte, avisos y modo Mini",
        Tipo = "Success",
        Duracion = 6,
    })
end)
