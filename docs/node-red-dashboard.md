# Node-RED Dashboard per al Shield IO

## Accés

- **Dashboard UI**: http://192.168.200.1:1880/ui/
- **Editor**: http://192.168.200.1:1880/

## Flow importat

El fitxer `nodered-flow/flow.json` conté el flow complet amb:

- **4 botons** (DQ0 ON, DQ0 OFF, DQ1 ON, DQ1 OFF)
- **2 indicadors d'estat** (mostren ON/OFF en verd/vermell)
- **5 lectures d'entrada** (DI0-DI4, actualitzen cada 2s)
- **2 readings de sortida** (confirmació d'estat DQ cada 2s)

## Instal·lar el flow manualment

1. Obre http://192.168.200.1:1880/
2. Menu (☰) → Import → Clipboard
3. Enganxa el contingut de `nodered-flow/flow.json`
4. Fes clic a **Deploy** (botó taronja a dalt a la dreta)

## Estructura del flow

```
┌───────────────────────────────────────────────────────────┐
│ Tab: Control IoT2050                                       │
├────────────────────────┬──────────────────────────────────┤
│ Group: Sortides (DQ)   │ Group: Entrades (DI)             │
│                        │                                  │
│ [DQ0 ⬤ ON] [DQ0 ◯ OFF]│ DI0 (Borne 1): [0/1]            │
│ DQ0: [⬤ ON / ◯ OFF]  │ DI1 (Borne 2): [0/1]            │
│                        │ DI2 (Borne 3): [0/1]            │
│ [DQ1 ⬤ ON] [DQ1 ◯ OFF]│ DI3 (Borne 4): [0/1]            │
│ DQ1: [⬤ ON / ◯ OFF]  │ DI4 (Borne 5): [0/1]            │
└────────────────────────┴──────────────────────────────────┘
```

## Nodes utilitzats

| Node | Tipus | Descripció |
|------|-------|------------|
| `exec_dq0` | exec | `echo {payload} > /sys/class/gpio/gpio355/value` |
| `exec_dq1` | exec | `echo {payload} > /sys/class/gpio/gpio360/value` |
| `exec_read_dq0` | exec | `cat /sys/class/gpio/gpio355/value` |
| `exec_read_dq1` | exec | `cat /sys/class/gpio/gpio360/value` |
| `exec_di0`-`di4` | exec | `cat /sys/class/gpio/gpio{437,438,439,441,345}/value` |
| `timer_dq`, `timer_di` | inject | Timer cada 2s per refrescar estats |
| `btn_dq*` | ui_button | Botons ON/OFF al dashboard |
| `status_dq*` | ui_text | Indicador d'estat al dashboard |
| `status_di*` | ui_text | Lectura d'entrades al dashboard |

## Instal·lar node-red-dashboard (si no està)

```bash
cd /usr/lib/node_modules/node-red
npm install node-red-dashboard
systemctl restart node-red
```
