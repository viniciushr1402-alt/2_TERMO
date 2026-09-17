const entrada = require('readline-sync')

console.log("CALCULO")

const gasolina = entrada.questionFloat("Qual o valor da gasolina")
const valor = entrada.questionFloat("Qual o valor do alcol")

const diference = valor / gasolina 

    if (diference <= 0.7) {
    console.log("Abasteça com alcool! E melhor !")
} else {
    console.log("Abasteça com gasolina! E melhor!")
}
