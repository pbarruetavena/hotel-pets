import express from 'express';
const estadiaRoutes = express.Router();
import estadiaController from '../controller/estadiaController';

estadiaRoutes.get("/", estadiaController.listarEstadia);
estadiaRoutes.post("/", estadiaController.criarEstadia);
estadiaRoutes.put("/:id", estadiaController.atualizarEstadia);
estadiaRoutes.delete("/:id", estadiaController.apagarEstadia);

export default estadiaRoutes;