import { Request, Response } from "express";
import { AtualizaUserUseCase } from "./AtualizaUserUseCase";

export class AtualizaUserController {
    async handle(req: Request, res: Response) {
        
        const atualizaUserUseCase = new AtualizaUserUseCase();

        const { id, email, senha } = req.body;
        
        const result = await atualizaUserUseCase.execute(id, email, senha);
        return res.status(201).json(result);
    }
}