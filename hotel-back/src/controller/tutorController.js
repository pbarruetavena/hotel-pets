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

const atualizarTutor = async (request, response) => {
    try {
        const { id } = request.params;
        const dadosAtualizados = request.body;

        const res = await tutorService.updateTutor(id, dadosAtualizados);
        response.status(200).json(res);
    } catch(err) {
        response.status(400).json({error: err.message});
    }
};

const apagarTutor = async (request, response) => {
    try {
        const {id} = request.params;
        const res = await tutorService.deleteTutor(id);

        if(res.message == "SequelizeForeignKeyConstraintError") {
            return response.status(409).json({message: "Não foi possível apagar o tutor. Tente apagar todos os animais dependentes."});
        }
        response.status(200).json(res);
    } catch(err) {
        response.status(400).json({message: err.message});
    }
}

export default {listarTutores, criarTutor, atualizarTutor, apagarTutor};