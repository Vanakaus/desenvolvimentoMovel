import { Request, Response } from "express";
import { LoginUserUseCase } from "./LoginUserUseCase";

export class LoginUserController {
    async handle(req: Request, res: Response) {
        
        const loginUserUseCase = new LoginUserUseCase();

        const { email, senha } = req.body;
        
        const result = await loginUserUseCase.execute(String(email), String(senha)) as any;

        result.status = "success"
        result.message = "Login efetuado!"


        return res.status(201).json(result);
    }
}