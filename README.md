# IoT2050 IO Shield — Siemens 6ES7647-0KA01-0AA2

Documentació del **shield IO Siemens 6ES7647-0KA01-0AA2** (Arduino Shield) connectat al **SIMATIC IOT2050 Basic PG2**.

## 📋 Descripció

El mòdul **6ES7647-0KA01-0AA2** (SIMATIC IoT2000 Input/Output Module) proporciona E/S digitals i analògiques per al IoT2050:

- **5x DI** — Entrades digitals (24V DC)
- **2x DQ** — Sortides digitals (transistor, 24V DC, 0.3A)
- **2x AI** — Entrades analògiques (0-10V DC)

## 🔌 Accés SSH

| Paràmetre | Valor |
|-----------|-------|
| IP | `192.168.200.1` |
| Usuari | `root` |
| Contrasenya | `123456` |

## 🗺️ Pinout — Connexions als bornes

| Borne | Senyal | GPIO | Sysfs | Descripció |
|-------|--------|------|-------|------------|
| 1 | DI0 | gpio437 | `/sys/class/gpio/gpio437/value` | Entrada digital 0 |
| 2 | DI1 | gpio438 | `/sys/class/gpio/gpio438/value` | Entrada digital 1 |
| 3 | DI2 | gpio439 | `/sys/class/gpio/gpio439/value` | Entrada digital 2 |
| 4 | DI3 | gpio441 | `/sys/class/gpio/gpio441/value` | Entrada digital 3 |
| 5 | DI4 | gpio345 | `/sys/class/gpio/gpio345/value` | Entrada digital 4 |
| 6 | AI0 | — | A0 (ADC) | Entrada analògica 0 (0-10V) |
| 7 | AI1 | — | A1 (ADC) | Entrada analògica 1 (0-10V) |
| **8** | **DQ0** | **gpio355** | **`/sys/class/gpio/gpio355/value`** | **Sortida digital 0** |
| **9** | **DQ1** | **gpio360** | **`/sys/class/gpio/gpio360/value`** | **Sortida digital 1** |
| 10 | +24V DQ | — | — | Alimentació externa DQ (+) |
| 11 | 0V DQ | — | — | Massa DQ |
| 12 | +24V | — | — | Alimentació del mòdul |
| 13 | 0V/GND | — | — | Massa general |

## 🎛️ Node-RED Dashboard

El dashboard està disponible a:
- **Dashboard UI**: http://192.168.200.1:1880/ui/
- **Editor**: http://192.168.200.1:1880/

### Control de les sortides DQ0 i DQ1

Des del dashboard pots activar/desactivar les sortides amb botons ON/OFF:

```
┌─────────────────────────────────────┐
│  🔌 CONTROL IoT2050                  │
├────────────────┬────────────────────┤
│ SORTIDES (DQ)  │ ENTRADES (DI)      │
│                │                    │
│ [DQ0 ⬤ ON]    │ DI0 (Borne 1): 0   │
│ [DQ0 ◯ OFF]   │ DI1 (Borne 2): 0   │
│ DQ0: ◯ OFF    │ DI2 (Borne 3): 0   │
│                │ DI3 (Borne 4): 0   │
│ [DQ1 ⬤ ON]    │ DI4 (Borne 5): 0   │
│ [DQ1 ◯ OFF]   │                    │
│ DQ1: ◯ OFF    │                    │
└────────────────┴────────────────────┘
```

### ⚠️ Important

Les sortides DQ **necessiten alimentació externa** (24V DC) als bornes 10 i 11. Sense alimentació externa, les sortides no commuten.

## 🔧 GPIO Mapping Detallat

El shield utilitza tres **PCAL9535** (expansors GPIO per I2C) per gestionar la configuració:

| I2C | Chip | GPIOs | Funció |
|-----|------|-------|--------|
| 1-0020 (0x20) | PCAL9535 | gpio496-511 | Pull-up resistors + enables |
| 1-0021 (0x21) | PCAL9535 | gpio480-495 | Direction control (IO0-IO13) |
| 1-0025 (0x25) | PCAL9535 | gpio464-479 | Pull-up control (IO0-IO13) |

### Control via sysfs

Les sortides es controlen escrivint directament als GPIOs del processador:

```bash
# Activar DQ0
echo 1 > /sys/class/gpio/gpio355/value

# Desactivar DQ0
echo 0 > /sys/class/gpio/gpio355/value

# Llegir DI0
cat /sys/class/gpio/gpio437/value
```

## 📁 Contingut del repositori

```
iot2050-io-shield/
├── README.md              ← Aquest fitxer
├── docs/
│   ├── pinout.md          ← Pinout detallat del connector
│   ├── node-red-dashboard.md ← Configuració del dashboard
│   └── ssh-access.md      ← Accés SSH
├── nodered-flow/
│   └── flow.json          ← Flow de Node-RED per importar
├── scripts/
│   ├── export-gpios.sh    ← Exporta i configura tots els GPIOs
│   └── setup-gpios.sh     ← Configuració d'arrencada
└── images/
    ├── pinout.jpg         ← Pinout del manual Siemens
    └── wiring.jpg         ← Esquema de cablejat
```

## 🚀 Configuració ràpida

```bash
# 1. Exportar GPIOs (una vegada)
echo 437 > /sys/class/gpio/export
echo 438 > /sys/class/gpio/export
echo 439 > /sys/class/gpio/export
echo 441 > /sys/class/gpio/export
echo 345 > /sys/class/gpio/export

# 2. Configurar direcció
echo in > /sys/class/gpio/gpio437/direction
echo out > /sys/class/gpio/gpio355/direction

# 3. Accedir al dashboard
# Obre http://192.168.200.1:1880/ui/
```

## 📄 Llicència

MIT
