# Automação de Testes de API com Robot Framework

📄 Este README está disponível em outros idiomas:
- [🇬🇧 English](README.md)

Este projeto é uma **suíte de automação de testes de API REST** desenvolvida com **Robot Framework**. Ele foi projetado para validar endpoints de API e garantir confiabilidade em diferentes cenários. Este repositório é estruturado para facilitar o uso e integra-se com **GitHub Actions** para Integração Contínua (CI).

## 🚀 Funcionalidades

- Testes automatizados de API usando **Robot Framework** e **Requests Library**
- Estrutura modular e reutilizável de testes
- GitHub Actions para execução automatizada dos testes em pipelines de CI/CD
- Relatórios e logs gerados após cada execução de teste
- Variáveis de ambiente fáceis de configurar para diferentes cenários de teste

## 📂 Estrutura do Projeto

```
APItest_Robot-main/
├── .github/workflows/ci.yml   # Workflow do GitHub Actions para testes automatizados
├── RESOURCES/
│   ├── variables/api_variables.resource  # Configuração de variáveis da API
├── TESTS/api/
│   ├── users.robot          # Casos de teste da API
│   ├── log.html             # Log detalhado da execução
│   ├── report.html          # Relatório de testes
│   ├── output.xml           # Resultados da execução
├── main.resource            # Recursos comuns do Robot Framework
├── requirements.txt         # Dependências
└── README.pt-br.md          # Documentação do projeto (este arquivo)
```

## 🛠️ Configuração e Instalação

### Pré-requisitos
- Python 3.8+
- Robot Framework
- Biblioteca Requests para Robot Framework

### Instalação
1. Clone o repositório:
   ```sh
   git clone https://github.com/luisfsilveira9/APItest_Robot.git
   cd APItest_Robot
   ```
2. Instale as dependências:
   ```sh
   pip install -r requirements.txt
   ```

## ▶️ Executando os Testes

Para executar os testes de API, execute:
```sh
robot TESTS/api/users.robot
```

Após a execução, verifique os arquivos `log.html` e `report.html` para resultados detalhados.

## 🔄 Integração CI/CD com GitHub Actions
Este projeto inclui um workflow do GitHub Actions (`.github/workflows/ci.yml`) que aciona a execução automatizada de testes a cada push ou pull request na branch principal.

## 📜 Relatórios de Testes
Após a execução dos testes, relatórios detalhados de execução e logs estarão disponíveis:
- **`log.html`** – Detalhes da execução e logs de erros
- **`report.html`** – Resumo dos casos de teste aprovados/reprovados

## 📌 Melhorias Futuras
- Adicionar mais casos de teste para diferentes endpoints da API
- Implementar configurações específicas para diferentes ambientes
- Ampliar a cobertura de testes para incluir cenários negativos

## 📝 Licença
Este projeto é de código aberto e está disponível sob a licença MIT.

---

🎯 **Projeto de Portfólio**: Este projeto faz parte do meu portfólio para demonstrar minhas habilidades em automação de testes de API com Robot Framework.


