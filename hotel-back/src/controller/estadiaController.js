import { response } from "express";
import estadiaService from "../services/estadiaService";

const listarEstadia = async (request, response) => {
    try {
        const estadias = await estadiaService.listAllEstadia();
        response.json(estadias);
    }
    catch (err) {
        response.status(500).json({error: err.message});
    }
}

const criarEstadia = async (request, response) => {
    try {
        const {entrada, saida, animalId} = request.body;
        const estadia = await estadiaService.createEstadia(entrada, saida, animalId);
        response.status(201).json(estadia);
    } catch (err) {
        response.status(400).json({error: err.message});
    }
}

const atualizarEstadia = async (request, response) => {
    try {
        const {id} = request.params;
        const dadosAtualizados = request.body;

        const res = await estadiaService.updateEstadia(id, dadosAtualizados);
        response.status(200).json(res);
    } catch (err) {
        response.status(400).json({error: err.message});
    }
}

const apagarEstadia = async (request, params) => {
    try {
        const {id} = request.params;
        const res = estadiaService.deleteEstadia(id);

        response.status(200).json(res);
    } catch(err) {
        response.status(400).json({error: err.message});
    }
}

export default {listarEstadia, criarEstadia, atualizarEstadia, apagarEstadia};