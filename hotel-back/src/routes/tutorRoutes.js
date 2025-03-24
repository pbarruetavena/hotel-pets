import express from 'express';
const tutorRouter = express.Router();
import tutorController from '../controller/tutorController.js';

tutorRouter.get("/", tutorController.listarTutores);
tutorRouter.post("/", tutorController.criarTutor);

export default tutorRouter;