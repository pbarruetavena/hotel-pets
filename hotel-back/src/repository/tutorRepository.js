import Tutor from "../models/Tutor.js";

const getTutores = async () => {
    return await Tutor.findAll();
};

const addTutor = async (nome, email) => {
    return await Tutor.create({nome, email});
};

export default {getTutores, addTutor};