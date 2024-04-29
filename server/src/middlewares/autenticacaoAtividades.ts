import e, { NextFunction } from 'express';
import { prisma } from '../prisma/client';
import { AppError } from '../errors/AppErrors';


export async function autenticacaoAtividade(req: e.Request, res: e.Response, next: NextFunction) {

    console.log('\n');
    console.log('Autenticando:');
    console.log(`ID: ${req.headers["x-access-id"]}`);
    console.log(`Email: ${req.headers["x-access-email"]}`);

    const atividade = await prisma.userAtividades.findUnique({
        where: {
            id: Number(req.headers["x-access-id"])
        },
        select: {
            id: true,
            id_aluno: true,
        }
    });


    if(!atividade || req.headers["x-access-id"] != atividade?.id_aluno.toString()){
        console.log('Falha na Autenticação');
        throw new AppError('Falha na Autenticação', 401);
    }

    console.log('\n');
    console.log('Autenticado com sucesso!');


    return next();
}

