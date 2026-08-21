

function calcularKwh(potencia, horas) {
    return (potencia * horas) / 1000;
};

function calcularCusto(totalkwh, precokwh) {
    return totalkwh * precokwh;
};

function classConsumo(totalkwh) {
    if (totalkwh < 100) {
        return "Consumo Baixo ";
    } else {
        return "Consumo Elevado";
    }
};

module.exports = {
calcularKwh,
calcularCusto,
classConsumo
};

