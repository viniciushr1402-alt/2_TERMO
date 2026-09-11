function checarTemperatura(valor) {
    if (valor > 40) {
        return "ALERTA: Caldeira Superaquecida";
    }
    return "Temperatura normal";
}

function checarUmidade(valor) {
    if (valor < 20) {
        return "ALERTA: Ar muito seco";
    }
    return "Umidade normal";
}


module.exports = {
    checarTemperatura,
    checarUmidade
};
