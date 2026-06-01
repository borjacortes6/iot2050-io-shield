# IoT2050 IO Shield — Pràctica per a alumnes

## 📖 Manual oficial Siemens

Descarrega el manual complet aquí:
- **Siemens Support:** https://support.industry.siemens.com/cs/document/109745681/iot2000-extension-modules-operating-instructions
- **Document:** `A5E39456816-AB_Operating_Instructions_IOT2000_Extension_Modules_1910.pdf`

---

## 📦 Models del shield

| Model | Descripció |
|-------|-----------|
| **6ES7647-0KA01-0AA2** ⬅️ El nostre | **Input/Output Module** — 5x DI, 2x AI, **2x DQ** (amb sortides) |
| 6ES7647-0KA02-0AA2 | Input Module Sink/Source — 8x DI (només entrades) |

> El **0KA01** és el model complet amb **sortides digitals (DQ)**. El **0KA02** només té entrades.

---

# 🔧 PART 1 — HARDWARE

## 🔍 1.1 Estructura física del mòdul

**Secció 1.2.1 del manual (Pàg. 7):**

![Estructura del mòdul I/O - Pàg 7](images/structure-page7.png)

*Pàg 7 del manual: estructura del mòdul amb descripció de cada connector*

### Llegenda del mòdul 6ES7647-0KA01-0AA2:

| Núm. | Connector | Descripció |
|------|-----------|------------|
| ① | **Analog interface M** | Massa de les entrades analògiques |
| | **U0, U1** | Entrades de tensió analògica (0-10V) → **Bornes 6, 7** |
| | **I0, I1** | Entrades de corrent analògica (0-20mA) |
| ② | **Digital output interface M** | Massa de les sortides digitals |
| | **DO0, DO1** | Sortides digitals (24V, 0.3A) → **Bornes 8 (DQ0), 9 (DQ1)** |
| ③ | **Digital input interface** | Entrades digitals → **Bornes 1-5 (DI0-DI4)** |
| | **M** | Massa de les entrades digitals |
| ④ | **X1** | Connector de bornes principal (13 pins) |
| ⑤ | **X2** | Alimentació externa per a les sortides DQ |
| ⑥ | **X3** | Connector Arduino (acoblament al IoT2050) |

---

## 🔌 1.2 Pinout del connector X1 (bornes)

**Secció 4.2.3 del manual — Hardware Interface (Pàg. 30):**

![Hardware Interface Pinout](images/hardware-interface-pinout.png)

*Pàg 30: taula d'assignació de pins del connector X1*

### Taula resum de connexions:

| Borne | Senyal | Funció | Observacions |
|-------|--------|--------|-------------|
| 1 | **DI0** | Entrada digital 0 | 24V DC (0: <5V, 1: >12V) |
| 2 | **DI1** | Entrada digital 1 | 24V DC |
| 3 | **DI2** | Entrada digital 2 | 24V DC |
| 4 | **DI3** | Entrada digital 3 | 24V DC |
| 5 | **DI4** | Entrada digital 4 | 24V DC |
| 6 | **AI0** | Entrada analògica 0 | 0-10V DC o 0-20mA |
| 7 | **AI1** | Entrada analògica 1 | 0-10V DC o 0-20mA |
| **8** | **DQ0** | **Sortida digital 0** | **24V, 0.3A, current-sourcing (PNP)** |
| **9** | **DQ1** | **Sortida digital 1** | **24V, 0.3A, current-sourcing (PNP)** |
| **10** | **+24V DQ** | **Alimentació externa DQ (+)** | **9-36V DC — obligatori per a les sortides!** |
| **11** | **0V DQ** | **Massa per a les sortides DQ** | **GND de la font externa** |
| 12 | **+24V** | Alimentació del mòdul | 24V DC |
| 13 | **0V/GND** | Massa del mòdul | GND |

---

## ⚡ 1.3 Cablejat de les sortides DQ

> 🔧 Important: Segons el datasheet (Pàg. 26 del manual), les DQ són **"current-sourcing" (PNP)**. Això vol dir que **proporcionen +24V** al borne 8/9 quan s'activen. Per tant, la càrrega es connecta **entre DQ i 0V DQ (borne 11)**.

**⚠️ REQUISIT INDISPENSABLE:** Les sortides DQ necessiten **alimentació externa de 24V DC** als bornes **10 (+24V DQ)** i **11 (0V DQ)**. Sense això, no funcionen encara que el software les activi.

### 1.3.1 Alimentació de les sortides DQ (Pàg. 20 del manual)

![Alimentació DQ](images/wiring-power-dq.png)

*Pàg 20: connexió de la font d'alimentació externa per a DQ0 i DQ1 (bornes 10 i 11)*

### 1.3.2 Connexió de les entrades digitals DI (Pàg. 21 del manual)

![Entrades digitals](images/wiring-digital-inputs.png)

*Pàg 21: connexió dels sensors / interruptors a les entrades DI0-DI4*

### 1.3.3 Connexió de les sortides digitals DQ (Pàg. 22 del manual)

![Sortides digitals i entrades analògiques](images/wiring-digital-outputs-analog.png)

*Pàg 22: connexió de càrregues a DQ0/DQ1 i sensors analògics a AI0/AI1*

### 1.3.4 Esquema resum de cablejat

```
               ┌──────────────────────────────┐
               │        IoT2050 + Shield        │
               │                               │
  [Borne 12]───┤ +24V   (alimentació mòdul)    │
  [Borne 13]───┤ GND    (massa mòdul)          │
               │                               │
  [Borne 10]───┤ +24V DQ ──── Font 24V DC (+)  │
  [Borne 11]───┤ 0V DQ  ──── Font 24V DC (-)  │
               │                               │
  [Borne  8]───┤ DQ0 ──── Càrrega ────┐       │
               │                      │        │
  [Borne 11]───┤ 0V DQ ───────────────┘       │
               │                               │
  [Borne  1]───┤ DI0 ──── Sensor/Polsador      │
               └──────────────────────────────┘
```

### 1.3.5 Exemple pràctic amb LED

```
Borne 10 (+24V DQ) ────────────────── Font 24V (+)
Borne 11 (0V DQ)   ────────────────── Font 24V (-)

Borne 8 (DQ0) ──── LED 🔴 ──── R 1kΩ ──── Borne 11 (0V DQ)
```

**Funcionament:**
- Quan s'activa DQ0 → el borne 8 es posa a +24V → el LED s'encén
- Quan es desactiva DQ0 → el borne 8 es posa a 0V → el LED s'apaga

### 1.3.6 Prova amb multímetre (sense càrrega)

Mode **V⎓ DC**:

| Mesurar entre | DQ0 = ON | DQ0 = OFF |
|--------------|----------|-----------|
| **Borne 8 (DQ0)** i **Borne 11 (0V DQ)** | ~24V ✅ | ~0V ❌ |

> 💡 El multímetre mesura la tensió que **surt** del borne 8 respecte a GND (borne 11).

---

# 💻 PART 2 — SOFTWARE

## 🔌 2.1 Accés al IoT2050 via PuTTY

1. Obre **PuTTY**
2. Configura:
   - **Host Name:** `192.168.200.1`
   - **Port:** `22`
   - **Connection type:** `SSH`
3. Fes clic a **Open**
4. Usuari: `root`
5. Contrasenya: `123456`

> ✅ Ja ets dins del IoT2050!

### Comandes bàsiques per explorar el sistema

```bash
# Informació del sistema
uname -a

# Quin model d'IoT2050 és?
cat /proc/device-tree/model

# Quins gpiochips hi ha?
gpiodetect
```

---

## 🔍 2.2 Descobrir els GPIOs de les sortides DQ

Les sortides DQ0 i DQ1 estan connectades als GPIOs del processador del IoT2050. Per saber quins números de GPIO tenen, cal explorar el sistema.

### Pas 1: Identificar els gpiochips

```bash
gpiodetect
```

Al nostre IoT2050 hi ha **6 gpiochips**. Els que ens interessen són els que tenen els senyals **IO0-IO13**:

| Chip | GPIOs | Dispositiu | Funció |
|------|-------|-----------|--------|
| **gpiochip3** | **408-463** | **42110000.gpio** | **GPIOs del processador** |
| **gpiochip4** | **312-407** | **600000.gpio** | **GPIOs del processador** |
| gpiochip1 | 480-495 | PCAL9535 (I2C) | Direcció IO0-IO13 |
| gpiochip0 | 496-511 | PCAL9535 (I2C) | Pull-ups |

### Pas 2: Llistar les línies de cada chip

```bash
gpioinfo gpiochip3
gpioinfo gpiochip4
```

A **gpiochip3** (base 408, 56 línies) trobem les **entrades digitals**:
```
line 29: "IO0" → gpio408+29 = gpio437 → DI0 (Borne 1)
line 30: "IO1" → gpio408+30 = gpio438 → DI1 (Borne 2)
line 31: "IO2" → gpio408+31 = gpio439 → DI2 (Borne 3)
line 33: "IO3" → gpio408+33 = gpio441 → DI3 (Borne 4)
```

A **gpiochip4** (base 312, 96 línies) trobem més entrades i les **sortides**:
```
line 33: "IO4" → gpio312+33 = gpio345 → DI4 (Borne 5)
line 43: "IO7" → gpio312+43 = gpio355 → DQ0 (Borne 8) ✅
line 48: "IO8" → gpio312+48 = gpio360 → DQ1 (Borne 9) ✅
```

### Pas 3: Fórmula per calcular el número de GPIO

```
Número GPIO = BASE_DEL_CHIP + NÚMERO_DE_LÍNIA

Exemple per DQ0: gpiochip4 (base 312) + line 43 (IO7) = gpio355
```

### Pas 4: Confirmació experimental

```bash
# Llegir l'estat actual de DQ0
cat /sys/class/gpio/gpio355/value

# Activar DQ0
echo 1 > /sys/class/gpio/gpio355/value

# Comprovar que ha canviat
cat /sys/class/gpio/gpio355/value
# → Ha de tornar "1"
```

> 📝 La sortida **DQ0 = gpio355** és un número que depèn de com el kernel de Linux assigna els controladors en arrencar. En un altre IoT2050 podria ser diferent, per això és important saber com descobrir-ho.

---

## ⚙️ 2.3 Configurar i controlar els GPIOs

### 2.3.1 Exportar els GPIOs (si no ho estan)

```bash
echo 355 > /sys/class/gpio/export
echo 360 > /sys/class/gpio/export
```

> Si dona l'error "Device or resource busy", vol dir que ja estan exportats.

### 2.3.2 Configurar la direcció com a OUTPUT

```bash
echo out > /sys/class/gpio/gpio355/direction   # DQ0 com a sortida
echo out > /sys/class/gpio/gpio360/direction   # DQ1 com a sortida
```

### 2.3.3 Activar i desactivar les sortides

```bash
# DQ0 ON
echo 1 > /sys/class/gpio/gpio355/value
# El borne 8 es posa a +24V → el LED s'encén

# DQ0 OFF
echo 0 > /sys/class/gpio/gpio355/value
# El borne 8 es posa a 0V → el LED s'apaga

# DQ1 ON
echo 1 > /sys/class/gpio/gpio360/value

# DQ1 OFF
echo 0 > /sys/class/gpio/gpio360/value
```

### 2.3.4 Llegir l'estat actual

```bash
cat /sys/class/gpio/gpio355/value   # Retorna 0 (OFF) o 1 (ON)
cat /sys/class/gpio/gpio360/value
```

### 2.3.5 Script per a l'arrencada automàtica

Per evitar fer-ho manualment cada vegada:

```bash
nano /etc/rc.local
```

Afegiu abans del `exit 0`:

```bash
# Exportar GPIOs del shield IO
echo 355 > /sys/class/gpio/export 2>/dev/null
echo 360 > /sys/class/gpio/export 2>/dev/null

# Configurar com a sortides
echo out > /sys/class/gpio/gpio355/direction
echo out > /sys/class/gpio/gpio360/direction

# Inicialitzar a OFF
echo 0 > /sys/class/gpio/gpio355/value
echo 0 > /sys/class/gpio/gpio360/value
```

Després:
```bash
chmod +x /etc/rc.local
```

---

## 🎛️ 2.4 Node-RED: Dashboard amb botons ON/OFF

### 2.4.1 Instal·lar node-red-dashboard (si no està)

```bash
cd /usr/lib/node_modules/node-red
npm install node-red-dashboard
systemctl restart node-red
```

### 2.4.2 Importar el flow

1. Obre **http://192.168.200.1:1880/** al navegador
2. Menú ☰ → **Import** → **Clipboard**
3. Obre el fitxer `nodered-flow/flow.json` i enganxa'l
4. Fes clic a **Deploy** (botó taronja a dalt a la dreta)

### 2.4.3 Estructura del flow

```
┌─────────────────────────────────────────────────┐
│              Timer (cada 3s)                     │
│         Llegeix l'estat de DQ0 i DQ1            │
└────────┬──────────────┬─────────────────────────┘
         │              │
  ┌──────▼──────┐  ┌───▼────────┐
  │ Llegir DQ0  │  │ Llegir DQ1 │
  └──────┬──────┘  └────┬───────┘
         │              │
  ┌──────▼──────┐  ┌───▼────────┐
  │ Estat DQ0   │  │ Estat DQ1  │
  └─────────────┘  └────────────┘

┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐
│ DQ0 ⬤ ON│   │ DQ0 ◯ OFF│   │ DQ1 ⬤ ON│   │ DQ1 ◯ OFF│
└────┬─────┘   └────┬─────┘   └────┬─────┘   └────┬─────┘
     │              │              │              │
     └──────┬───────┘              └──────┬───────┘
            │                            │
     ┌──────▼──────┐              ┌──────▼──────┐
     │ Exec DQ0    │              │ Exec DQ1    │
     │ echo > gpio355/value       │ echo > gpio360/value
     └─────────────┘              └─────────────┘
```

### 2.4.4 Accedir al Dashboard

Obre al navegador:

> **http://192.168.200.1:1880/ui/**

Veureu 4 botons:

```
┌──────────────────────────────────────────┐
│  🎛️ CONTROL IoT2050                      │
├──────────────────────────────────────────┤
│  SORTIDES DIGITALS                       │
│                                          │
│  ┌──────────────┐  ┌──────────────┐      │
│  │  DQ0 ⬤ ON   │  │  DQ0 ◯ OFF  │      │
│  └──────────────┘  └──────────────┘      │
│  Estat DQ0: 0                            │
│                                          │
│  ┌──────────────┐  ┌──────────────┐      │
│  │  DQ1 ⬤ ON   │  │  DQ1 ◯ OFF  │      │
│  └──────────────┘  └──────────────┘      │
│  Estat DQ1: 0                            │
└──────────────────────────────────────────┘
```

### 2.4.5 Com funciona cada botó

| Botó | Acció | Comando que s'executa |
|------|-------|----------------------|
| DQ0 ⬤ ON | Activa DQ0 | `echo 1 > /sys/class/gpio/gpio355/value` |
| DQ0 ◯ OFF | Desactiva DQ0 | `echo 0 > /sys/class/gpio/gpio355/value` |
| DQ1 ⬤ ON | Activa DQ1 | `echo 1 > /sys/class/gpio/gpio360/value` |
| DQ1 ◯ OFF | Desactiva DQ1 | `echo 0 > /sys/class/gpio/gpio360/value` |

Cada botó és un node `ui_button` que envia `"1"` o `"0"` a un node `exec`. L'exec fa un `echo` amb redirecció `>` al fitxer del GPIO corresponent.

---

## 🧪 Prova ràpida completa

### Des de PuTTY (SSH):

```bash
# 1. Exportar GPIOs
echo 355 > /sys/class/gpio/export
echo 360 > /sys/class/gpio/export

# 2. Configurar com a sortides
echo out > /sys/class/gpio/gpio355/direction
echo out > /sys/class/gpio/gpio360/direction

# 3. Provar DQ0
echo 1 > /sys/class/gpio/gpio355/value   # 🔵 LED ON (si esteu connectats)
echo 0 > /sys/class/gpio/gpio355/value   # ⚫ LED OFF

# 4. Provar DQ1
echo 1 > /sys/class/gpio/gpio360/value   # 🔵 ON
echo 0 > /sys/class/gpio/gpio360/value   # ⚫ OFF
```

### Des del Node-RED:

1. Obre **http://192.168.200.1:1880/ui/**
2. Prem els botons i observa els indicadors

> ⚠️ **Si no funciona:** Comprova que tens 24V DC als bornes 10 i 11, i que el GPIO està en mode "out" (`cat /sys/class/gpio/gpio355/direction`).

---

## 📁 Contingut del repositori

```
iot2050-io-shield/
├── README.md                    ← Aquesta guia (hardware + software)
├── docs/
│   └── node-red-dashboard.md    ← Configuració avançada
├── nodered-flow/
│   └── flow.json                ← Flow de Node-RED (4 botons)
├── scripts/
│   ├── export-gpios.sh          ← Exporta i configura GPIOs
│   └── setup-gpios.sh           ← Per a rc.local (arrencada)
└── images/
    ├── structure-page7.png      ← Pàg 7: estructura del mòdul
    ├── hardware-interface-pinout.png ← Pàg 30: pinout X1
    ├── wiring-power-dq.png      ← Pàg 20: alimentació DQ
    ├── wiring-digital-inputs.png← Pàg 21: connexions DI
    └── wiring-digital-outputs-analog.png ← Pàg 22: connexions DQ+AI
```

## 📄 Llicència

MIT — Ús educatiu lliure
