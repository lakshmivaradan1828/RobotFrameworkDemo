*** Settings ***
Library        OperatingSystem
Library        REST    https://jsonplaceholder.typicode.com/   ssl_verify=false
##Resource       Variables.robot
# Test Setup     Starting
# Test Teardown  Close Browser
*** Variables ***
${Json}    {"title":"foo","body":"bar","userId":${id}}
${id}    10

*** Test Cases ***
Rest GET test1
    Get   /posts/${id}/comments
    Output  response body
    Integer   response status   200
Rest GET test2
    Get   /albums/${id}/photos
    Output  response body
    Integer   response status   200
Rest GET test3
    Get   /users/${id}/posts
    Output  response body
    Integer   response status   200
Rest POST test
    Post   /posts    ${Json}
    Output  response body
    Integer   response body userId    ${id}
