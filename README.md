# Software-Defined Radio (SDR) in FPGA: BASK Modem

Implementação completa de um sistema de Rádio Definido por Software (SDR) em hardware, cobrindo o fluxo ponta-a-ponta de modulação, transmissão, recepção e reconstrução de sinais de sinais de comunicação.

## 🎯 Arquitetura do Projeto
O sistema foi desenvolvido utilizando RTL Design (Verilog) abordando domínios lógicos e de sinais mistos (Mixed-Signal):
* **Transmissão (TX):** Geração do sinal modulante via Síntese Digital Direta (DDS) utilizando Lookup Table (LUT).
* **Aquisição:** Interface de hardware personalizada para integração e amostragem contínua via conversor A/D (MCP3002).
* **Modulação RF:** Geração lógica do sinal BASK (OOK) sobre uma portadora de 100 kHz.
* **Recepção e DAC (RX):** Recuperação da informação, reamostragem digital dos bits e conversão Digital-Analógico nativa através de síntese PWM de alta frequência (204 kHz).

## 📊 Resultados de Bancada (Mixed-Signal Validation)
O projeto foi totalmente validado em hardware integrando a FPGA a Filtros Passa-Faixa e Passa-Baixa analógicos. 

**1. Sinal Original Gerado (DDS)**
<img width="565" height="346" alt="canvas2" src="https://github.com/user-attachments/assets/1b6acf27-6410-4763-8d27-7b8b93b19f0b" />


**2. Sinal Analógico Reconstruído no Receptor**
<img width="644" height="375" alt="canvas3" src="https://github.com/user-attachments/assets/0d32b807-9258-46bb-a906-cc487626b9ee" />
