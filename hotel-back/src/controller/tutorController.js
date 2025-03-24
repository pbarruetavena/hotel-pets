import tutorService from "../services/tutorService.js";

const listarTutores = async (request, response) => {
    try {
        const tutor = await tutorService.listAllTutores();
        response.json(tutor);
    } catch(error) {
        response.status(500).json({error: error.message});
    }
};

const criarTutor = async (request, response) => {
    try {
        console.log(request.body);
        const {nome, email}= request.body;
        console.log(nome + '   --   ' + email + '   ---  teste')
        const tutor = await tutorService.createTutor(nome, email);
        response.status(201).json(tutor);
    } catch(error) {
        response.status(400).json({error: error.message});
    }
};

export default {listarTutores, criarTutor};