*** Variables ***
# API URL
${API_URL}        https://reqres.in
${USER_EMAIL}     eve.holt@reqres.in
${USER_PASSWORD}  pistol

# API Endpoints
${API_USERS}         /api/users
${API_USERS_ID}      /api/users/{id}
${API_USERS_PAGE}    /api/users?page={page}
${API_REGISTER}      /api/register
${API_LOGIN}         /api/login