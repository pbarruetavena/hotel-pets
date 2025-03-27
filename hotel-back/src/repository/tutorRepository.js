import Tutor from "../models/Tutor.js";

const getTutores = async () => {
    return await Tutor.findAll();
};

const addTutor = async (nome, email) => {
    return await Tutor.create({nome, email});
};

const updateTutor = async (id, dadosAtualizados) => {
    const tutor = await Tutor.findByPk(id);
    if (!tutor) {
        throw new Error("Tutor não encontrado");
    }

    await tutor.update(dadosAtualizados);
    return tutor;
};

const deleteTutor = async (id) => {
    const tutor = await Tutor.findByPk(id);
    if (!tutor) {
        throw new Error("Tutor não encontrado");
    }
    try {
        await tutor.destroy();
        return { message: "Tutor removido com sucesso" };
    } catch(err) {
        if(err.name === "SequelizeForeignKeyConstraintError") {
            return {message: "SequelizeForeignKeyConstraintError"}
        }
    }

};

const find = async (id) => {
    return await Tutor.findByPk(id);
}

export default {getTutores, addTutor, updateTutor, deleteTutor, find};