*** Settings ***
Resource    ../../main.resource
Resource    ../../RESOURCES/variables/api_variables.resource

*** Test Cases ***
Criar Usuário
    [Documentation]    Teste de criar usuário usando API 
    Create Session    api_session    ${API_URL}
    ${payload}=    Create Dictionary  name=Teste    job=QA
    ${response}=    POST On Session    api_session    ${API_USERS}    json=${payload}
    Should Be Equal As Strings    ${response.status_code}    201
    Should Not Be Empty   ${response.json()}
    Log    ${response.json()}

        # Extrair o ID do Usuário Criado
    ${response_json}=    Convert To Dictionary    ${response.json()}
    ${user_id}=    Get From Dictionary    ${response_json}    id
    
    # Validar que o ID foi Retornado
    Should Not Be Empty    ${user_id}
    Log    ID do Usuário Criado: ${user_id}
    
    # Salvar o ID em uma Variável Global
    Set Global Variable    ${USER_ID}    ${user_id}

Editar Usuário com PUT
    [Documentation]    Teste de editar o usuário criado com PUT
    ${payload}=    Create Dictionary    name=Teste Editado PUT   job=DevOps
    ${endpoint}=    Replace String    ${API_USERS_ID}    {id}    ${USER_ID}
    ${response}=    PUT On Session    api_session    ${endpoint}    json=${payload}
    
    # Validar Status Code
    Should Be Equal As Strings    ${response.status_code}    200

    # Validar que o Usuário Foi Atualizado
    ${response_json}=    Convert To Dictionary    ${response.json()}
    Should Be Equal As Strings    ${response_json["name"]}    Teste Editado PUT
    Should Be Equal As Strings    ${response_json["job"]}    DevOps

Editar Usuário com PATCH
    [Documentation]    Teste de editar o usuário criado com PATCH
    ${payload}=    Create Dictionary    name=Teste Editado PATCH    job=DevOps
    ${endpoint}=    Replace String    ${API_USERS_ID}    {id}    ${USER_ID}
    ${response}=    PATCH On Session    api_session    ${endpoint}    json=${payload}
    
    # Validar Status Code
    Should Be Equal As Strings    ${response.status_code}    200

    # Validar que o Usuário Foi Atualizado
    ${response_json}=    Convert To Dictionary    ${response.json()}
    Should Be Equal As Strings    ${response_json["name"]}    Teste Editado PATCH
    Should Be Equal As Strings    ${response_json["job"]}    DevOps

Deletar Usuário
    [Documentation]    Teste de deletar o usuário criado
    ${endpoint}=    Replace String    ${API_USERS_ID}    {id}    ${USER_ID}
    ${response}=    DELETE On Session    api_session    ${endpoint}
    
    # Validar Status Code
    Should Be Equal As Strings    ${response.status_code}    204
Listar Usuário por ID
    [Documentation]    Teste de listar usuário usando API 
    Create Session    api_session    ${API_URL}
    ${endpoint}=      Replace String    ${API_USERS_ID}    {id}    2
    ${response}=      GET On Session    api_session    ${endpoint}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Not Be Empty   ${response.json()}
    Log    ${response.json()}

    # Extrair JSON do Response
    ${response_json}=    Convert To Dictionary    ${response.json()}
    
    # Validar Campos de "data"
    ${data}=    Get From Dictionary    ${response_json}    data
    Should Not Be Empty    ${data}
    Should Be True    ${data["id"]} != None
    Should Not Be Empty    ${data["email"]}
    Should Not Be Empty    ${data["first_name"]}
    Should Not Be Empty    ${data["last_name"]}
    Should Not Be Empty    ${data["avatar"]}

        # Validar Campos de "support"
    ${support}=    Get From Dictionary    ${response_json}    support
    Should Not Be Empty    ${support}
    Should Not Be Empty    ${support["url"]}
    Should Not Be Empty    ${support["text"]}
    
    # Logar o JSON no Console
    Log    ${response_json}

Listar Pagina de Usuários
    [Documentation]    Teste de listar uma pagina de usuários usando API 
    Create Session    api_session    ${API_URL}
    ${endpoint}=      Replace String    ${API_USERS_PAGE}    {page}    1
    ${response}=      GET On Session    api_session    ${endpoint}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Not Be Empty   ${response.json()}
    Log    ${response.json()}

Listar usuário inexistente
    [Documentation]    Teste de listar usuário inexistente usando API 
    Create Session    api_session    ${API_URL}
    ${endpoint}=      Replace String    ${API_USERS_ID}    {id}    23
    ${response}=      GET On Session    api_session    ${endpoint}    expected_status=any
    Should Be Equal As Strings    ${response.status_code}    404
    Should Be Empty   ${response.json()}
    Log    ${response.json()}

Registro de Usuário
    [Documentation]    Teste de registro de usuário com validação de ID e Token
    ${payload}=    Create Dictionary    email=${USER_EMAIL}    password=${USER_PASSWORD}
    ${response}=    POST On Session    api_session    ${API_REGISTER}    json=${payload}
    
    # Validar Status Code
    Should Be Equal As Strings    ${response.status_code}    200
    
    # Validar Response
    ${response_json}=    Convert To Dictionary    ${response.json()}
    ${user_id}=    Get From Dictionary    ${response_json}    id
    ${token}=      Get From Dictionary    ${response_json}    token
    Should Be True    ${user_id} != None
    Should Not Be Empty    ${token}
    Log    ID: ${user_id}, Token: ${token}

    # Salvar Token em Variável Global
    Set Global Variable    ${REGISTERED_TOKEN}    ${token}

Registro com Dados Faltando
    [Documentation]    Teste de registro sem password
    Create Session    api_session    ${API_URL}
    ${payload}=    Create Dictionary    email=${USER_EMAIL}    password=${None}
    ${response}=    POST On Session    api_session    ${API_REGISTER}    json=${payload}    expected_status=any
    
    # Validar Status Code
    Should Be Equal As Strings    ${response.status_code}    400
    
    # Validar Mensagem de Erro
    ${response_json}=    Convert To Dictionary    ${response.json()}
    ${error}=    Get From Dictionary    ${response_json}    error
    Should Be Equal As Strings    ${error}    Missing password

Login Positivo
    [Documentation]    Teste de login válido com validação do token
    Create Session    api_session    ${API_URL}
    ${payload}=    Create Dictionary    email=${USER_EMAIL}    password=${USER_PASSWORD}
    ${response}=    POST On Session    api_session    ${API_LOGIN}    json=${payload}
    
    # Validar Status Code
    Should Be Equal As Strings    ${response.status_code}    200

    # Validar Token
    ${response_json}=    Convert To Dictionary    ${response.json()}
    ${token}=    Get From Dictionary    ${response_json}    token
    Should Not Be Empty    ${token}
    Should Be Equal As Strings    ${token}    ${REGISTERED_TOKEN}
    Log    Token: ${token}

Login com Dados Faltando
    [Documentation]    Teste de login sem password
    Create Session    api_session    ${API_URL}
    ${payload}=    Create Dictionary    email=peter@klaven    password=null
    ${response}=    POST On Session    api_session    ${API_LOGIN}    json=${payload}    expected_status=any
    
    # Validar Status Code
    Should Be Equal As Strings    ${response.status_code}    400
    
    # Validar Mensagem de Erro
    ${response_json}=    Convert To Dictionary    ${response.json()}
    ${error}=    Get From Dictionary    ${response_json}    error
    Should Be Equal As Strings    ${error}    user not found