*** Settings ***
Test Setup        Start browser
Test Teardown     Close All Browsers
Library           SeleniumLibrary    timeout=10    implicit_wait=1.5    run_on_failure=Capture Page Screenshot  
Library           FakerLibrary    locale=pt_BR

*** Variables ***
${BROWSER}        chrome
${REMOTE_URL}     http://www.lourencodemonaco.com.br/vvtest/

*** Test Cases ***
Via Varejo Page Test
    ${NOME}    FakerLibrary.Firstname
    ${SOBRENOME}    FakerLibrary.Lastname
    ${EMAIL}    FakerLibrary.Email
    ${EMAIL2}    Get Variable Value    ${EMAIL}
    ${TEL}    FakerLibrary.Phone Number
    ${ABOUT}    FakerLibrary.Sentence

    Maximize Browser Window 
    Click Element    xpath=//a[contains(text(),'Pesquisa – QA')]    #Passo 2 "E acesse o menu "Pesquisa - QA"
    
    # Passo 3 "Quando eu preencher todos os campos obrigatórios"
    Input Text    xpath=(.//*[@type='text'])[1]    ${NOME}
    Input Text    xpath=(.//*[@type='text'])[2]    ${SOBRENOME}
    Input Text    xpath=.//*[@type='email']    ${EMAIL}
    Input Text    xpath=.//*[@id='nf-field-8']    ${EMAIL2}
    Input Text    xpath=.//*[@type='tel']    ${TEL}
    Click Element    xpath=//label[contains(text(),'31-49')]
    Select From List By Value    name:nf-field-11    mais-de-5-anos
    Select From List By Value    name:nf-field-12    sou-mega-chato
    Click Element    xpath=(.//*[@class='nf-field-element']//li)[5]
    Click Element    xpath=//label[contains(text(),'Negócio')]
    Input Text    name:nf-field-14    JS, Python, Ruby
    Input Text    name:nf-field-15    ${ABOUT}.
    Click Element    xpath=.//*[@id='nf-field-16']
    Sleep    2
    # Passo 4 "Então deve ser direcionado para uma página de sucesso"
    Page Should Contain    Pesquisa para o profissional da área de Qualidade:
    Element Should Contain    //*[@id="nf-form-2-cont"]/div/div[1]/p    successfully
    Page Should Contain Element    xpath=//p[contains(text(),'Your form has been successfully submitted.')]

*** Keywords ***
Start Browser    #Passo 1 "Dado que eu acesse a página da VV Test"
    [Documentation]    Start browser
    Open Browser    ${REMOTE_URL}    ${BROWSER}
