import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import animalRouter from './routes/animalRoutes.js';
import tutorRouter from './routes/tutorRoutes.js';
import syncd from "./models/index.js";
dotenv.config();

const app = express();
app.use(express.json());
app.use(cors());

app.use('/animal', animalRouter);
app.use('/tutor', tutorRouter)
// app.get('/', (req, res) => {
//     console.log('teste basico');
//     res.send('funcionou');
// });

syncd().then(() => {
    const port = 3000;
    app.listen(port, () => {
        console.log("aplicativo rodando");
    });
});