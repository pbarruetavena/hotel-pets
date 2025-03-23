const express = require("express");
const router = express.Router();
const animalController = require("../controller/animalController");

router.get("/animal", animalController.listAllAnimais);
router.post("/animal", animalController.createAnimal);

module.exports = router;