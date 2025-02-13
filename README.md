# API Test Automation with Robot Framework

📄 This README is available in other languages:
- [🇧🇷 Português](README.pt-br.md)

This project is a **REST API test automation suite** built using **Robot Framework**. It is designed to validate API endpoints and ensure reliability in different scenarios. This repository is structured for ease of use and integrates with **GitHub Actions** for Continuous Integration (CI).

## 🚀 Features

- Automated API tests using **Robot Framework** and **Requests Library**
- Modular and reusable test structure
- GitHub Actions for automated test execution in CI/CD pipelines
- Reports and logs generated after each test run
- Easy-to-configure environment variables for different testing scenarios

## 📂 Project Structure

```
APItest_Robot-main/
├── .github/workflows/ci.yml   # GitHub Actions workflow for automated testing
├── RESOURCES/
│   ├── variables/api_variables.resource  # API variables configuration
├── TESTS/api/
│   ├── users.robot          # API test cases
│   ├── log.html             # Detailed execution log
│   ├── report.html          # Test report
│   ├── output.xml           # Execution results
├── main.resource            # Common Robot Framework resources
├── requirements.txt         # Dependencies
└── README.md                # Project documentation (this file)
```

## 🛠️ Setup & Installation

### Prerequisites
- Python 3.8+
- Robot Framework
- Robot Framework Requests Library

### Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/luisfsilveira9/APItest_Robot.git
   cd APItest_Robot
   ```
2. Install dependencies:
   ```sh
   pip install -r requirements.txt
   ```

## ▶️ Running the Tests

To execute the API tests, run:
```sh
robot TESTS/api/users.robot
```

After execution, check the generated `log.html` and `report.html` for detailed results.

## 🔄 CI/CD Integration with GitHub Actions
This project includes a GitHub Actions workflow (`.github/workflows/ci.yml`) that triggers automated test execution on each push or pull request to the main branch.

## 📜 Test Reports
After running the tests, detailed execution reports and logs will be available:
- **`log.html`** – Execution details and error logs
- **`report.html`** – Summary of passed/failed test cases

## 📌 Future Improvements
- Add more test cases for different API endpoints
- Implement environment-specific configurations
- Extend test coverage to include negative scenarios

## 📝 License
This project is open-source and available under the MIT License.

---

🎯 **Portfolio Project**: This project is part of my portfolio to demonstrate my API test automation skills using Robot Framework.

