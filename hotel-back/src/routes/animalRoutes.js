import express from 'express';
const animalRouter = express.Router();
import animalController from '../controller/animalController.js';

animalRouter.get("/", animalController.listarAnimais);
// animalRouter.get("/", (req, res)=> {
//     console.log('funcionou !');
//     res.send('funcionou');
// });
animalRouter.post("/", animalController.criarAnimal);
animalRouter.put("/:id", animalController.atualizarAnimal);
animalRouter.delete("/:id", animalController.apagarAnimal);

export default animalRouter;