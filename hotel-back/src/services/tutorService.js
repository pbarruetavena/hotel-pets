import tutorRepository from "../repository/tutorRepository.js";

const listAllTutores = async () => {
    return await tutorRepository.getTutores();
};

const createTutor = async (nome, email) => {
    if(!nome || !email) throw new Error("Insira todos os dados");
    return await tutorRepository.addTutor(nome, email);
};

export default {listAllTutores, createTutor};