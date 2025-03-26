import express from 'express';
const tutorRouter = express.Router();
import tutorController from '../controller/tutorController.js';

tutorRouter.get("/", tutorController.listarTutores);
tutorRouter.post("/", tutorController.criarTutor);
tutorRouter.put("/:id", tutorController.atualizarTutor);
tutorRouter.delete("/:id", tutorController.apagarTutor);

export default tutorRouter;