import { Request, Response } from "express";
import { CriaAtividadeUseCase } from "./criaAtividadeUseCase";

export class CriaAtividadeController {
    async handle(req: Request, res: Response) {
        
        const { titulo, descricao, dataLimite } = req.body;
        const criaAtividadeUseCase = new CriaAtividadeUseCase();
        
        const result = await criaAtividadeUseCase.execute({titulo, descricao, dataLimite});
        return res.status(201).json(result);
    }
}