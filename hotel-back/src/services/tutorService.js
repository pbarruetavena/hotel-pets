import tutorRepository from "../repository/tutorRepository.js";

const listAllTutores = async () => {
    return await tutorRepository.getTutores();
};

const createTutor = async (nome, email) => {
    if(!nome || !email) throw new Error("Insira todos os dados");
    return await tutorRepository.addTutor(nome, email);
};

const updateTutor = async (id, dadosAtulizados) => {
    return await tutorRepository.updateTutor(id, dadosAtulizados);
}

const deleteTutor = async (id) => {
    return await tutorRepository.deleteTutor(id);
}

export default {listAllTutores, createTutor, updateTutor, deleteTutor};