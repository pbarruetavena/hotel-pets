const express = require('express');
const dotenv = require('dotenv');
const cors = require('cors');
const animalRoutes = require('../src/routes/animalRoutes');
const { sync } = require('../src/models');