# Pinout Detallat del Connector X1

## Siemens 6ES7647-0KA01-0AA2 — I/O Shield per IoT2050

### Bornes de connexió (X1)

```
┌────────────────────────────────────────────────────┐
│  CONNECTOR X1 — Bornes de cargol (13 posicions)    │
├──────┬────────────┬────────┬────────────────────────┤
│ Borne│ Senyal     │ GPIO   │ Descripció             │
├──────┼────────────┼────────┼────────────────────────┤
│  1   │ DI 0       │ gpio437│ Entrada digital 0      │
│  2   │ DI 1       │ gpio438│ Entrada digital 1      │
│  3   │ DI 2       │ gpio439│ Entrada digital 2      │
│  4   │ DI 3       │ gpio441│ Entrada digital 3      │
│  5   │ DI 4       │ gpio345│ Entrada digital 4      │
│  6   │ AI 0       │ A0     │ Entrada analògica 0    │
│  7   │ AI 1       │ A1     │ Entrada analògica 1    │
│  8   │ DQ 0       │ gpio355│ ⭐ Sortida digital 0   │
│  9   │ DQ 1       │ gpio360│ ⭐ Sortida digital 1   │
│  10  │ +24V DQ    │ —      │ Alimentació DQ (+)     │
│  11  │ 0V DQ      │ —      │ Alimentació DQ (-)     │
│  12  │ +24V       │ —      │ Alimentació mòdul (+)  │
│  13  │ 0V/GND     │ —      │ Alimentació mòdul (-)  │
└──────┴────────────┴────────┴────────────────────────┘
```

### Especificacions tècniques

#### Entrades Digitals (DI)
- Quantitat: 5
- Tensió nominal: 24V DC
- Senyal "0": < 5V DC
- Senyal "1": > 12V DC
- Corrent típica: 2.1mA (a "1")

#### Sortides Digitals (DQ)
- Quantitat: 2
- Tipus: Transistor (col·lector obert)
- Tensió màxima: 28.8V DC
- Corrent màxim: **0.3A per sortida**
- Protegides contra curtcircuits: Sí
- Freqüència de commutació:
  - Càrrega resistiva: màx. 10 Hz
  - Càrrega inductiva: màx. 0.5 Hz

#### Entrades Analògiques (AI)
- Quantitat: 2
- Rang: 0-10V DC (unipolar)
- Impedància d'entrada: 38 kΩ

### Alimentació
- Tensió d'alimentació del mòdul: 9-36V DC
- Tensió d'alimentació DQ: 9-36V DC (externa independent)

### Esquema de cablejat per a sortida DQ

```
          ┌────────────┐
          │   IoT2050  │
          │   Shield   │
          │     IO     │
          │            │
          │  ┌──────┐  │
          │  │ DQ 0 │──┼─────── Càrrega (relé, vàlvula, LED...)
          │  └──────┘  │                    │
          │            │                    │
          │  ┌──────┐  │                    │
          │  │+24V  │──┼─────── 24V DC ─────┘
          │  │ DQ   │  │       extern
          │  └──────┘  │
          │  ┌──────┐  │
          │  │ 0V   │──┼─────── GND extern
          │  │ DQ   │  │
          │  └──────┘  │
          └────────────┘
```

Nota: La sortida DQ commuta a **0V** (sink/col·lector obert) quan s'activa.
