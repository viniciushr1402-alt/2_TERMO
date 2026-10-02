function calcularTotal(preco, qtd){
    return preco * qtd;
}

function GeraCupom(nome, valor){
    return `Cliente: ${nome} Total: R$ ${valor.toFixed(2)}`;
}

module.exports = {
    calcularTotal,
    GeraCupom
};