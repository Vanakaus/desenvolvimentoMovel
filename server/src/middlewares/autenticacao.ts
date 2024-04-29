import e, { NextFunction } from 'express';
import { prisma } from '../prisma/client';
import { AppError } from '../errors/AppErrors';


export async function autenticacao(req: e.Request, res: e.Response, next: NextFunction) {

    console.log('\n');
    console.log('Autenticando:');
    console.log(`ID: ${req.body.id}`);
    console.log(`Email: ${req.body.email}`);


    const users = await prisma.user.findUnique({
        where: {
            email: req.body.email
        },
        select: {
            id: true,
            name: true,
            senha: true,
        }
    });

    if(!users){
        console.log('Falha na Autenticação');
        throw new AppError('Falha na Autenticação', 401);
    }


    return next();
}

